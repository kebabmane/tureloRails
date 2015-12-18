class FeedEntry < ActiveRecord::Base
  searchkick  callbacks: :async, track: true, conversions: "conversions"
  has_paper_trail
  acts_as_taggable
  acts_as_likeable

  belongs_to :feed, :counter_cache => true
  has_many :feed_entry_images, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :entry_id, presence: true, uniqueness: true

  def self.add_entries(entries, feed)
     entries.each do |entry|
         FeedEntry.where(entry_id: entry.id).first_or_create! do |feed_entry|
         feed_entry.entry_id           = entry.id
         feed_entry.feed_id            = feed.id
         feed_entry.feed_entry_url     = entry.url
         feed_entry.title              = entry.title
         feed_entry.summary            = entry.summary
         feed_entry.author             = entry.author
         feed_entry.feed_entry_content = entry.content
         feed_entry.published          = entry.published
         feed_entry.save

         FeedEntryImageWorker.perform_async(feed_entry.id)

         feed_entry.feed.followers(User).each do |user|
           Notification.create(recipient: user, actor: user, action: "new entry", notifiable: feed_entry)
         end

        end
       end
     end


end
