using DotEnv

DotEnv.load()

# alpaca api stocks bars endpoint
url = "https://broker-api.sandbox.alpaca.markets/v1/assets"

req_get(url, query, headers)

function get_assets_us_equity()
    # query
    query = Dict(
        "statue" => "all",
        "asset_class" => "us_equity"
    )
    # header
    header = Dict(
        "APCA-API-KEY-ID" => ENV["APCA_API_KEY_ID"],
        "APCA-API-SECRET-KEY" => ENV["APCA_API_SECRET_KEY"]
    )
end