module Api
 module V1
  class OverviewsController < Api::BaseController


  # GET /feeds
  # GET /feeds.json
  def index
    if params[:search].present?
      @feed_entries = FeedEntry.includes(:feed, :feed_entry_images, :impressions).all.order("published DESC").search(params[:search], suggest: true, track: true, page: params[:page], per_page: 9)
   elsif params[:tag].present?
      @feed_entries = FeedEntry.tagged_with(params[:tag]).order("published DESC").page(params[:page]).per_page(9)
   else
      @feed_entries = FeedEntry.where(feed_id: current_user.followees(Feed)).order("published DESC").includes(:feed, :feed_entry_images).page(params[:page]).per_page(9)
   end
 end 




end
end
end
