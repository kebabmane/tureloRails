class Feed < ActiveRecord::Base
  extend FriendlyId
  friendly_id :feed_name, use: [:slugged, :finders]
  searchkick match: :word_start, searchable: [:feed_name], callbacks: :async, track: true, conversions: "conversions"
  has_paper_trail
  acts_as_paranoid
  acts_as_taggable
  acts_as_followable
  is_impressionable :counter_cache => true, :unique => true

  validates :feed_url, presence: true, uniqueness: true
  validates :feed_name, :slug, presence: true

  has_many :feed_entries, dependent: :destroy

end
