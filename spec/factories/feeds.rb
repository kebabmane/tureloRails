# == Schema Information
#
# Table name: feeds
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  feed_name           :string
#  feed_url            :string
#  number_feed_entries :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  deleted_at          :datetime
#  feed_icon           :string
#  last_fetched        :datetime
#  status              :integer
#  feed_entries_count  :integer
#  followers_count     :integer          default(0)
#  followees_count     :integer          default(0)
#  description         :string
#  favicon_url         :string
#  slug                :string
#  impressions_count   :integer
#  mentioners_count    :integer          default(0)
#  mentionees          :integer          default(0)
#  likers_count        :integer          default(0)
#  feed_description    :string
#  feed_image_url      :string
#  category_id         :integer
#

FactoryGirl.define do
  factory :feed do
    belongs_to ""
feed_name "MyString"
feed_url "MyString"
feed_entries ""
  end

end
