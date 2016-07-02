class Feed < ActiveRecord::Base
  searchkick match: :word_start, searchable: [:feed_name], callbacks: :async, track: true, conversions: "conversions"
  has_paper_trail
  acts_as_paranoid
  acts_as_taggable
  acts_as_followable

  has_many :feed_entries, dependent: :destroy

  validates :feed_url, presence: true, uniqueness: true

end
