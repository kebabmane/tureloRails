class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :category_name, use: [:slugged, :finders]
  has_many :feeds

  mount_uploader :category_image_url, MediaUploader

  validates :category_name, presence: true, uniqueness: true
end
