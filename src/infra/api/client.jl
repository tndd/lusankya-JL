using DotEnv
using HTTP

DotEnv.config()

const ENDPOINTS = Dict(
    "alpaca" => Dict(
        "asset" => "https://broker-api.sandbox.alpaca.markets/v1/assets",
        "bar" => "https://data.alpaca.markets/v2/stocks/bars"
    )
)


struct ApiResponse
    url::String
    query::Dict
    header::Dict
    r_status::Int
    r_header::Dict
    r_body::String
end


function r_get(url::String, query::Dict, header::Dict)::ApiResponse
    r = HTTP.get(url, query=query, headers=header)
    return ApiResponse(
        url,
        query,
        header,
        r.status,
        Dict(r.headers),
        String(r.body)
    )
end


function r_get_as_alpaca(url::String, query::Dict)::ApiResponse
    header = Dict(
        "APCA-API-KEY-ID" => ENV["APCA_API_KEY_ID"],
        "APCA-API-SECRET-KEY" => ENV["APCA_API_SECRET_KEY"]
    )
    return r_get(url, query, header)
end