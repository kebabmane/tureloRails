class FeedEntryImageWorker
  include Sidekiq::Worker

  def perform(feed_entry)

    if feed_entry
     @feed_entry = FeedEntry.find(feed_entry)

        doc = Nokogiri::HTML(@feed_entry.summary)
        img_srcs = doc.css('img').map{ |i| i['src'] }
        img_srcs.each_with_index do |url, index|
          if index == 0
            FeedEntryImage.create!(
              :img_url              => url,
              :feed_entry_id        => @feed_entry.id,
            )
          else
         end
       end


        doc = Nokogiri::HTML(@feed_entry.feed_entry_content)
        img_srcs = doc.css('img').map{ |i| i['src'] }
        img_srcs.each_with_index do |url, index|
          if index == 0
            FeedEntryImage.create!(
              :img_url              => url,
              :feed_entry_id        => @feed_entry.id,
            )
          else
         end
       end

   end
  end


 end
