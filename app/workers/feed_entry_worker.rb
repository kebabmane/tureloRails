class FeedEntryWorker
  include Sidekiq::Worker

  def perform(feed_id)
    @feed = Feed.find(feed_id)
    url = @feed.feed_url
    @get_feed = Feedjira::Feed.fetch_and_parse url

    @get_feed.new_entries.each do |little_feed|
        @feed_entry = @feed.feed_entries.new
        @feed_entry.title = little_feed.title
        @feed_entry.author = little_feed.author
        @feed_entry.feed_entry_url = little_feed.id
        @feed_entry.published = little_feed.published
        if little_feed.content
          @feed_entry.feed_entry_content = little_feed.content
        elsif litte_feed.summary
          @feed_entry.feed_entry_content = little_feed.summary
        end
        @feed_entry.save
    end
  end

end
