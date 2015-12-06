class FeedEntryWorker
  include Sidekiq::Worker

  def perform(feed_id)
    @feed = Feed.find(feed_id)
    url = @feed.feed_url
    @get_feed = Feedjira::Feed.fetch_and_parse url
    @updated_feed = Feedzirra::Feed.update(@get_feed)

    @updated_feed.new_entries.each do |little_feed|
        @feed_entry = @feed.feed_entries.new
        @feed_entry.title = little_feed.title
        @feed_entry.author = little_feed.author
        @feed_entry.feed_entry_url = little_feed.links
        @feed_entry.published = little_feed.published
        @feed_entry.feed_entry_content = little_feed.content
        @feed_entry.save
    end
  end

end
