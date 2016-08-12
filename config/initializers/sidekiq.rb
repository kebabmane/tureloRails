schedule_file = "config/schedule.yml"

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: :resque }
end


Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: :resque }
end
