require 'redis'
redis_url = ENV["REDISCLOUD_URL"] || "redis://localhost:6379/0/cache"
REDIS = Redis.new(url: redis_url)
