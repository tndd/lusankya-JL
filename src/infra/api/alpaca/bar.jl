using HTTP
using JSON
using DotEnv

# Alpaca APIエンドポイント
url = "https://data.alpaca.markets/v2/stocks/bars"

# リクエストパラメータ
params = Dict(
    "symbols" => "AAPL",
    "start" => "2022-01-03T00:00:00Z",
    "end" => "2022-12-31T00:00:00Z",
    "timeframe" => "1Min"
)

DotEnv.load()


# APIキー
headers = Dict(
    "APCA-API-KEY-ID" => ENV["APCA_API_KEY_ID"],
    "APCA-API-SECRET-KEY" => ENV["APCA_API_SECRET_KEY"]
)

# HTTPリクエストを行い、レスポンスを取得
response = HTTP.get(url, query=params, headers=headers)

# レスポンスをJSON形式でパース
# data = JSON.parse(String(response.body))

# データを表示
# println(data)

print(String(response.body))