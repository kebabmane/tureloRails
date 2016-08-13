

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: "turelo-production", :size => 12 }

  schedule_file = "config/schedule.yml"

  if File.exists?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash! YAML.load_file(schedule_file)
  end
end


Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"], namespace: "turelo-production", :size => 8 }
end
