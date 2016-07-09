class Feed < ActiveRecord::Base
  extend FriendlyId
  searchkick match: :word_start, searchable: [:feed_name], callbacks: :async, track: true, conversions: "conversions"
  has_paper_trail
  acts_as_paranoid
  acts_as_taggable
  acts_as_followable
  friendly_id :feed_name, use: :slugged

  has_many :feed_entries, dependent: :destroy

  validates :feed_url, presence: true, uniqueness: true

end
