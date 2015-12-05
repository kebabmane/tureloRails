class Feed < ActiveRecord::Base
  searchkick
  has_paper_trail
  acts_as_paranoid
  acts_as_taggable

  has_many :feed_entries

end
