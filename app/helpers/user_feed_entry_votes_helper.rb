module UserFeedEntryVotesHelper

  def link_to_upvote(object)
    button_to 'like!', vote_path(object), method: :post, class: 'btn btn-primary btn-sm top-buffer'
  end

  def link_to_downvote(object)
    button_to 'unlike!', vote_path(object), method: :delete, class: 'btn btn-danger btn-sm top-buffer'
  end

  def render_votes_for_feed_entry(feed_entry)
    if current_user && @votes[feed_entry.id].include?(current_user.id)
      link_to_downvote(feed_entry)
    else
      link_to_upvote(feed_entry.id)
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
