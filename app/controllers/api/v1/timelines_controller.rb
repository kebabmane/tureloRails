module Api
 module V1
  class TimelinesController < Api::BaseController
    before_filter :authenticate_user!

    respond_to :json

  def index
      @feed_entries = FeedEntry.where(feed_id: current_user.followees(Feed)).order("published DESC").includes(:feed, :feed_entry_images).limit(30)
  end

  end
 end
end
