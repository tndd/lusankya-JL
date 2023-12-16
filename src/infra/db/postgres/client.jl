using DotEnv
using LibPQ


DotEnv.config()

pool = ConnectionPool(ENV["PSQL_URL"])


function transact_execute(queries::Vector{String})
    conn = acquire(pool)
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
        release(pool, conn)
    end
end


function parallel_execute(queries::Vector{String})
    threads = min(length(queries), 16)
    @threads for i in 1:threads
        chunk = queries[i:threads:n]
        transact_execute(chunk)
    end
end
