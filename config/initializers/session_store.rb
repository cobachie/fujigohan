redis_url = ENV["REDISCLOUD_URL"] || "redis://localhost:6379/0/cache"
Fujigohan::Application.config.session_store :redis_store, servers: redis_url
