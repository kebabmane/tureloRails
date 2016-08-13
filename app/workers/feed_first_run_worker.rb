class FeedFirstRunWorker
  include Sidekiq::Worker

  def perform(feed_id)
    @feed = Feed.find(feed_id)
    url = @feed.feed_url
    @get_feed = Feedjira::Feed.fetch_and_parse url
    FeedEntry.add_entries(@get_feed.entries, @feed)
    @feed.updated_at = Time.now
  end

end
