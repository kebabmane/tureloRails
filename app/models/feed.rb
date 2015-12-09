class Feed < ActiveRecord::Base
  searchkick  callbacks: :async, track: true, conversions: "conversions"
  has_paper_trail
  acts_as_paranoid
  acts_as_taggable

  has_many :feed_entries, dependent: :destroy

end
