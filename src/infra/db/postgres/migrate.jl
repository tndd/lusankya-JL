# include("client.jl")


function load_query(
        schema::String,
        command::String,
        name::String
    )::String
    filepath = joinpath(@__DIR__, "sql", schema, command, name * ".sql")
    return read(filepath, String)
end
