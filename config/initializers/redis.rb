require 'redis'
uri = URI.parse(ENV["REDISCLOUD_URL"] || "redis://localhost:6379/0/cache")
REDIS = Redis.new(host: uri.host, port: uri.port)
