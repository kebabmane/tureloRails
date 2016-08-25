class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  after_save :update_votes

  validates_uniqueness_of :votable_id, scope: [:user_id, :votable_type]


  def get_object
    return @object if @object && @object.valid?
    klass = votable_type.constantize
    return false unless klass.exists?
    @object = klass.find(votable_id)
  end

  def update_votes
    attrs = self.attributes.with_indifferent_access.slice(:votable_id, :votable_type)
    count = Vote.where(attrs).count
    feed_entry = get_object

    # Hot Score is a function defined inside:
    # db/migrate/20150405200823_add_hot_score_function.rb

    rank = feed_entry.class.where(id: feed_entry.id)
             .select("id, hot_score(#{count}, 0, created_at) as hot_score")
             .first.hot_score.to_i

    feed_entry.update(
      downvotes_count: 0,
      upvotes_count: count,
      score: count,
      rank: rank
    )
  end
end
