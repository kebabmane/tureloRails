class FeedWorker
  include Sidekiq::Worker

  def perform(feed_id)
    feed = Feed.find(feed_id)
    url = feed.feed_url
    get_feed = Feedjira::Feed.fetch_and_parse url
  end

end
