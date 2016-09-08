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

class Feed < ActiveRecord::Base
  extend FriendlyId
  friendly_id :feed_name, use: [:slugged, :finders]
  searchkick match: :word_start, searchable: [:feed_name], callbacks: :async, track: true, conversions: "conversions"
  acts_as_taggable
  acts_as_followable
  is_impressionable :counter_cache => true


  validates :feed_url, presence: true, uniqueness: true
  #validates :feed_name, :slug, presence: true

  has_many :feed_entries, dependent: :destroy
  belongs_to :category, :counter_cache => true
  has_many :feed_entry_images, :through => :feed_entries

end
