class Feed < ActiveRecord::Base
  extend FriendlyId
  friendly_id :feed_name, use: [:slugged, :finders]
  searchkick match: :word_start, searchable: [:feed_name], callbacks: :async, track: true, conversions: "conversions"
  acts_as_paranoid
  acts_as_taggable
  acts_as_followable
  is_impressionable :counter_cache => true

  validates :feed_url, presence: true, uniqueness: true
  validates :feed_name, :slug, presence: true

  has_many :feed_entries, dependent: :destroy
  has_many :feed_entry_images, :through => :feed_entries

end
