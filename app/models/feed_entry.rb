class FeedEntry < ActiveRecord::Base
  searchkick
  has_paper_trail
  acts_as_taggable

  belongs_to :feed
end
