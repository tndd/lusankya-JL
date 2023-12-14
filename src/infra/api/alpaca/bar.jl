include("../client.jl")

# alpaca api stocks bars endpoint
url = "https://data.alpaca.markets/v2/stocks/bars"

# query
query = Dict(
    "symbols" => "AAPL",
    "start" => "2022-01-03T00:00:00Z",
    "end" => "2022-12-31T00:00:00Z",
    "timeframe" => "1Min"
)

b = r_get_as_alpaca(url, query)
println(b.r_body)