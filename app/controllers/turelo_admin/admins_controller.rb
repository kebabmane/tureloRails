class TureloAdmin::AdminsController < ApplicationController
  before_filter :authenticate_user!

  # GET /admins
  # GET /admins.json
  def index
    authorize current_user
		@users = User.all.order("sign_in_count DESC").paginate(:page => params[:page], :per_page => 10)
		@user_count = User.count(:all)
    @feed_count = Feed.count(:all)
    @feed_entry_count = FeedEntry.count(:all)
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
    authorize current_user
  	@user = User.friendly.find(params[:id])
  end

  # GET /admins/new

end
