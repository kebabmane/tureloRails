class FeedEntryWorker
  include Sidekiq::Worker

  def perform(feed_id)
    feed = Feed.find(feed_id)
    url = feed.feed_url
    get_feed = Feedjira::Feed.fetch_and_parse url
    feed.update_attribute(:feed_name, get_feed.title)
    feed.update_attribute(:number_feed_entries, get_feed.entries.count)
  end

end
