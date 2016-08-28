class UserFeedEntryVotesController < ApplicationController
  before_action :set_item

  def create
    if current_user.votes.build(vote_params).save
      redirect_to :back, notice: "Upvoted."
    else
      redirect_to :back, notice: "Already Upvoted."
    end
  end

  def destroy
    vote = current_user.votes.where(vote_params).first
    if vote
      vote.destroy
      message = 'Removed Vote.'
    else
      message = 'No vote to remove.'
    end
  end

  private
  def set_item
    @feed_entry = FeedEntry.find(params[:id])
    unless @feed_entry
      return redirect_to :back, notice: "Could not find feed entry with #{params[:id]}"
    end
  end

  def vote_params
    {
      votable_id: @feed_entry.id,
      votable_type: @feed_entry.class.to_s
    }
  end
end
