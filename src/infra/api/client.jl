using DotEnv
using HTTP

DotEnv.config()

struct ApiRequest
    url::String
    query::Dict
    header::Dict
end


struct ApiResponse
    status::Int
    header::Dict
    body::Dict
end


struct ApiSnapshot
    session_id::Union{Int, Nothing}
    seq_n::Union{Int, Nothing}
    req::ApiRequest
    res::ApiResponse
end


function req_get(
        url::String,
        query::Dict,
        headers::Dict,
        session_id=Nothing,
        seq_n=Nothing
    )::ApiSnapshot
    # request
    r = HTTP.get(url, query=query, headers=headers)
    # response
    r_status::Int = r.status
    r_headers::Dict = Dict(r.headers)
    r_body::String = String(r.body)
    # store
    return ApiSnapshot(
        session_id,
        seq_n,
        ApiRequest(url, query, headers),
        ApiResponse(r_status, r_headers, r_body)
    )
end


function req_get_as_alpaca(url::String, query::Dict)
    header = Dict(
        "APCA-API-KEY-ID" => ENV["APCA_API_KEY_ID"],
        "APCA-API-SECRET-KEY" => ENV["APCA_API_SECRET_KEY"]
    )
    req_get(url, query, header)
end