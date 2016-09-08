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

require 'rails_helper'

RSpec.describe FeedEntryImage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
