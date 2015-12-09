class FeedWorker
  include Sidekiq::Worker

  def perform(feed_id)
    @feed = Feed.find(feed_id)
    url = @feed.feed_url
    @new_url = Feedbag.find url
    @feed.feed_url = @new_url.first
    @feed.save
    get_feed = Feedjira::Feed.fetch_and_parse @new_url.first
    @feed.update_attribute(:feed_name, get_feed.title)
    FeedEntryFirstRunWorker.perform_async(@feed.id)
  end

end
