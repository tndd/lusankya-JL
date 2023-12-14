using DotEnv

include("../client.jl")

DotEnv.load()

# alpaca api stocks bars endpoint
url = "https://data.alpaca.markets/v2/stocks/bars"

# query
query = Dict(
    "symbols" => "AAPL",
    "start" => "2022-01-03T00:00:00Z",
    "end" => "2022-12-31T00:00:00Z",
    "timeframe" => "1Min"
)

# header
headers = Dict(
    "APCA-API-KEY-ID" => ENV["APCA_API_KEY_ID"],
    "APCA-API-SECRET-KEY" => ENV["APCA_API_SECRET_KEY"]
)

b = req_get(url, query, headers)
println(b)