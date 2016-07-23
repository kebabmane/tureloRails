module Api
 module V1
  class OverviewsController < Api::BaseController


  # GET /feeds
  # GET /feeds.json
  def index
      @feed_entries = FeedEntry.where(feed_id: current_user.followees(Feed)).order("published DESC").includes(:feed, :feed_entry_images).page(params[:page]).per_page(9)
  end

  end
 end
end
