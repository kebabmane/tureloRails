class FeedCoverImageCronWorker
  include Sidekiq::Worker

  def perform
    @feeds = Feed.all
    @feeds.each do |feed|
      feed.feed_image_url = @feed.feed_entries.last.feed_entry_images.first.img_url
   end
  end


 end
