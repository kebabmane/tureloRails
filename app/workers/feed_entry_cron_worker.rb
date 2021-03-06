class FeedEntryCronWorker
  include Sidekiq::Worker

  def perform
   Feed.find_each batch_size: 100 do |feed|
     url = feed.feed_url
     @get_feed = Feedjira::Feed.fetch_and_parse url
     FeedEntry.add_entries(@get_feed.entries, feed)
     feed.updated_at = Time.now
   end
  end


 end
