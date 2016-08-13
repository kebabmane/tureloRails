require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(5.minutes, 'Run feed entry cron worker', tz: 'UTC') { FeedEntryCronWorker.perform_async }
  every(5.minutes, 'Run feed entry image cron worker', tz: 'UTC') { FeedImageCronWorker.perform_async }
  every(30.minutes, 'Run feed image cron worker', tz: 'UTC') { FeedCoverImageWorker.perform_async }
  every(1.day, 'Counter Cache Update', tz: 'UTC') { CounterCacheWorker.perform_async }
end
