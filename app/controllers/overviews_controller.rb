class OverviewsController < ApplicationController
  before_filter :authenticate_user!

 def index
   if params[:search].present?
     @feed_entries = FeedEntry.includes(:feed_entry_images).all.order("published DESC").search(params[:search], suggest: true, track: true, page: params[:page], per_page: 9)
  elsif params[:tag].present?
     @feed_entries = FeedEntry.tagged_with(params[:tag]).order("published DESC").page(params[:page]).per_page(9)
  else
     @feed_entries = FeedEntry.preload(:feed).includes(:feed_entry_images).where(feed_id: current_user.followees(Feed)).order("published DESC").page(params[:page]).per_page(9)
  end

  respond_to do |format|
    format.html
    format.js
  end

 end

end
