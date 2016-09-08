# == Schema Information
#
# Table name: categories
#
#  id                   :integer          not null, primary key
#  category_name        :string
#  feed_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  category_image_url   :string
#  category_description :string
#  feeds_count          :integer
#  slug                 :string
#

FactoryGirl.define do
  factory :category do
    category "MyString"
    feeds nil
  end
end
