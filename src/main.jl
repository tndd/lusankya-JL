using Redis

# Redisサーバーへ接続
conn = RedisConnection(host="localhost", port=49512)

set(conn, "foo", "bar")

println(get(conn, "foo"))

disconnect(conn)