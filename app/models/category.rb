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

class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :category_name, use: [:slugged, :finders]
  has_many :feeds

  mount_uploader :category_image_url, MediaUploader

  validates :category_name, presence: true, uniqueness: true
end
