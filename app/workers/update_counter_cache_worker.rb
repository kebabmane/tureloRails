class CounterCacheCronWorker
  include Sidekiq::Worker

  def perform
    Category.find_each { |category| Category.reset_counters(category.id, :feeds) }
    FeedEntry.find_each { |feed_entry| FeedEntry.reset_counters(feed_entry.id, :feed_entry_images) }
    Feed.find_each { |feed| Feed.reset_counters(feed.id, :feed_entries) }
  end

end
