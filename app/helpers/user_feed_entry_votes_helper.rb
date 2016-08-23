module UserFeedEntryVotesHelper
  def link_to_upvote(object)
    link_to 'like!', vote_feed_entry_path(object), method: :post, class: 'text-danger'
  end

  def link_to_downvote(object)
    link_to 'unlike!', vote_feed_entry_path(object), method: :delete, class: 'text-muted'
  end

  def render_votes_for_feed_entry(feed_entry=nil)
    if current_user && @votes[feed_entry].include?(current_user.id)
      link_to_downvote(feed_entry)
    else
      link_to_upvote(feed_entry)
    end
  end

  def render_link_to_user(user, options={})
    if user.disabled?
      user.username
    else
      link_to user.username, user, options
    end
  end
end
