class OverviewsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_overview, only: [:show, :edit, :update, :destroy]


 def index
   if params[:search].present?
     @feed_entry = FeedEntry.all.order("published DESC").search(params[:search], suggest: true, track: true, page: params[:page], per_page: 9)
  else
     @feed_entry = FeedEntry.all.order("published DESC").paginate(:page => params[:page], :per_page => 9)
  end
 end

end
