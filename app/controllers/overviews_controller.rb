class OverviewsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_overview, only: [:show, :edit, :update, :destroy]


 def index
   @feed_entry = FeedEntry.all.order("published DESC").paginate(:page => params[:page], :per_page => 9)
 end

end
