class FeedCoverImageCronWorker
  include Sidekiq::Worker

  def perform
    Feed.find_each do |feed|
      feed.feed_image_url = feed.feed_entries.last.feed_entry_images.first.img_url rescue nil
      feed.save
   end
  end


 end
