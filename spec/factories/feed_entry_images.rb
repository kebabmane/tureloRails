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

FactoryGirl.define do
  factory :feed_entry_image do
    feed_entry nil
img_url "MyString"
  end

end
