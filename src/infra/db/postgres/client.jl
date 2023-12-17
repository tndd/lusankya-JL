using .Threads
using DotEnv
using LibPQ

DotEnv.config()


function transact_execute(queries::Vector{String})
    try
        conn = LibPQ.Connection(ENV["PSQL_URL"])
        LibPQ.begin(conn)
        for query in queries
            execute(conn, query)
        end
        LibPQ.commit(conn)
    catch e
        LibPQ.rollback(conn)
        throw(e)
    finally
        close(conn)
    end
end


function parallel_execute(queries::Vector{String})
    n_query = length(queries)
    n_thread = min(n_query, 16)
    @threads for i in 1:n_thread
        chunk = queries[i:n_thread:n_query]
        transact_execute(chunk)
    end
end

println("OK")