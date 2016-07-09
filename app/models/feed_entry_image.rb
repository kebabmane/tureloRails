class FeedEntryImage < ActiveRecord::Base
  belongs_to :feed_entry, :counter_cache => true
end
