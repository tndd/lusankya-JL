# include("client.jl")


function load_query(
        schema::String,
        command::String,
        name::String
    )::String
    filepath = joinpath(@__DIR__, "sql", schema, command, name)
    return read(filepath, String)
end


sql = load_query("dataflow", "create", "api_snapshot.sql")
println(sql)