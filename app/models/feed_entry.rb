class FeedEntry < ActiveRecord::Base
  searchkick match: :word_start, searchable: [:title], callbacks: :async, track: true, conversions: "conversions"
  acts_as_taggable
  acts_as_likeable
  belongs_to :feed, :counter_cache => true
  is_impressionable :counter_cache => true
  has_many :feed_entry_images, dependent: :destroy
  after_save :extract_images


  validates :title, presence: true, uniqueness: true
  validates :entry_id, presence: true, uniqueness: true

  def self.add_entries(entries, feed)
     entries.each do |entry|
         FeedEntry.where(entry_id: entry.id).first_or_create do |feed_entry|
         feed_entry.entry_id           = entry.id
         feed_entry.feed_id            = feed.id
         feed_entry.feed_entry_url     = entry.url
         feed_entry.title              = entry.title
         feed_entry.summary            = entry.summary
         feed_entry.author             = entry.author
         feed_entry.feed_entry_content = entry.content
         feed_entry.published          = entry.published

         if entry.summary.blank?
           content_san = feed_entry.feed_entry_content.gsub(/<p>\s*(&nbsp;\s*)+/, "<p>")
           feed_entry.feed_entry_content_sanitized = ActionView::Base.full_sanitizer.sanitize(content_san).lstrip
         else
           summary_san = feed_entry.summary.gsub(/<p>\s*(&nbsp;\s*)+/, "<p>")
           feed_entry.summary_sanitized = ActionView::Base.full_sanitizer.sanitize(summary_san).lstrip
         end

         if entry.categories.blank?
           blacklist = Highscore::Blacklist.load %w{https http href com span nbsp the that them and can this real with span src feeds for its span> class= div> div nbsp; www. com/ content 2016/ http: https: href= }

           text = Highscore::Content.new Sanitize.fragment(feed_entry.feed_entry_content), blacklist
           text.configure do
              set :multiplier, 2
              set :upper_case, 3
              set :long_words, 2
              set :long_words_threshold, 15
              set :short_words_threshold, 3      # => default: 2
              set :bonus_multiplier, 2           # => default: 3
              set :vowels, 1                     # => default: 0 = not considered
              set :consonants, 5                 # => default: 0 = not considered
              set :ignore_case, true             # => default: false
              set :word_pattern, /[\w]+[^\s0-9]/ # => default: /\w+/
              set :stemming, true                # => default: false
          end

              if feed_entry.feed_entry_content.blank?
              text = Highscore::Content.new feed_entry.summary, blacklist
           	    text.keywords.top(2).each do |keyword|
             		   keyword.text   # => keyword text
             		   keyword.weight # => rank weight (float)
             		   feed_entry.tag_list.add(keyword.text)
                end
              else
               	text.keywords.top(2).each do |keyword|
             		keyword.text   # => keyword text
             		keyword.weight # => rank weight (float)
             		feed_entry.tag_list.add(keyword.text)
               end
              end
         else
           entry.categories.each do |keyword|
              feed_entry.tag_list.add(keyword)
           end
         end

         feed_entry.save

         #feed_entry.feed.followers(User).each do |user|
         #   Notification.create(recipient: user, actor: user, action: "feed_entry", notifiable: feed_entry)
         #end

        end
       end
     end

     private

     def extract_images
       FeedEntryImageWorker.perform_async(self.id)
     end

end
