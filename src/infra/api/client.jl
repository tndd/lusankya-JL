using HTTP

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
    session_id::Int
    seq_n::Int
    req::ApiRequest
    res::ApiResponse
end

function req_get(url::String, query::Dict, headers::Dict)
    # request
    r = HTTP.get(url, query=params, headers=headers)
    # response
    r_status::Int = r.status
    r_headers::Dict = Dict(r.headers)
    r_body::String = String(r.body)
    # store
end