using JSON
using Redis


# Redisサーバーへ接続
conn = RedisConnection(host="localhost", port=49512)

file = open("asset.json")
data = read(file, String)
close(file)


Redis.hset(conn, "api_alpaca_cache", "asset", data)


disconnect(conn)