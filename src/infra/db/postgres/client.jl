using DotEnv
using LibPQ


DotEnv.config()


function transact_execute(queries::Vector{String})
    conn = LibPQ.Connection(ENV["PSQL_URL"])
    try
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
    threads = min(length(queries), 16)
    Threads.@threads for i in 1:threads
        chunk = queries[i:threads:length(queries)]
        transact_execute(chunk)
    end
end
