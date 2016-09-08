# == Schema Information
#
# Table name: feed_entry_images
#
#  id            :integer          not null, primary key
#  feed_entry_id :integer
#  img_url       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class FeedEntryImage < ActiveRecord::Base
  belongs_to :feed_entry, :counter_cache => true
end
