class FeedCoverImageCronWorker
  include Sidekiq::Worker

  def perform
    @feeds = Feed.all
    @feeds.find_each(batch_size: 10) do |feed|
      feed.feed_image_url = feed.feed_entries.last.feed_entry_images.first.img_url
      feed.save
   end
  end


 end
