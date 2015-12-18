class FeedEntryImageWorker
  include Sidekiq::Worker

  def perform(feed_entry_id)

     @feed_entry = FeedEntry.find(feed_entry_id)

      doc = Nokogiri::HTML(@feed_entry.summary)
      img_srcs = doc.css('img').map{ |i| i['src'] }
      img_srcs.each do |url|
        FeedEntryImage.create!(
           :img_url              => url,
           :feed_entry_id        => @feed_entry.id,
        )
      end


      doc = Nokogiri::HTML(@feed_entry.feed_entry_content)
      img_srcs = doc.css('img').map{ |i| i['src'] }
      img_srcs.each do |url|
        FeedEntryImage.create!(
           :img_url              => url,
           :feed_entry_id        => @feed_entry.id,
        )
     end
  end


 end
