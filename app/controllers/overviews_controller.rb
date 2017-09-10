class OverviewsController < ApplicationController
  before_action :authenticate_user!
  impressionist

 def index
  order = params[:newest] ? {rank: :desc} : {published: :desc}

  if params[:search].present?
     @feed_entries = FeedEntry.includes(:feed, :feed_entry_images, :impressions).all.order("published DESC").search(params[:search], suggest: true, page: params[:page], per_page: 9)
  elsif params[:tag].present?
     @feed_entries = FeedEntry.tagged_with(params[:tag]).order("published DESC").page(params[:page]).per_page(9)
  else
     @feed_entries = FeedEntry.where(feed_id: current_user.followees(Feed)).order(order).includes(:feed, :feed_entry_images).page(params[:page]).per_page(9)
  end

  @votes = @feed_entries.includes(:votes).each_with_object({}) do |feed_entry, object|
    object[feed_entry.id] = feed_entry.votes.map(&:user_id)
  end


  respond_to do |format|
    format.html
    format.js
  end

 end

end
