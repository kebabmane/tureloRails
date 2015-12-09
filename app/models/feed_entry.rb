class FeedEntry < ActiveRecord::Base
  searchkick  callbacks: :async, track: true, conversions: "conversions"
  has_paper_trail
  acts_as_taggable

  belongs_to :feed, :counter_cache => true
  has_many :feed_entry_images, dependent: :destroy



  def self.add_entries(entries, feed)
     entries.each do |entry|
       if FeedEntry.exists?(entry_id: entry.id, feed_id: feed.id)
          break
       else
         feed_entry = FeedEntry.new
         feed_entry.entry_id           = entry.id
         feed_entry.feed_id            = feed.id
         feed_entry.feed_entry_url     = entry.url
         feed_entry.title              = entry.title
         feed_entry.summary            = entry.summary
         feed_entry.feed_entry_content = entry.content
         feed_entry.published          = entry.published
         feed_entry.save


           doc = Nokogiri::HTML(entry.summary)
           img_srcs = doc.css('img').map{ |i| i['src'] }
           img_srcs.each do |url|
             FeedEntryImage.create!(
                :img_url              => url,
                :feed_entry_id        => feed_entry.id,
             )
           end


           doc = Nokogiri::HTML(entry.content)
           img_srcs = doc.css('img').map{ |i| i['src'] }
           img_srcs.each do |url|
             FeedEntryImage.create!(
                :img_url              => url,
                :feed_entry_id        => feed_entry.id,
             )
          end



        end
       end
     end

     def extract_images()

     end

end
