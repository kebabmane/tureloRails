class TureloAdmin::UsersController < ApplicationController
  before_filter :authenticate_user!

  # GET /admins
  # GET /admins.json
  def index
    #authorize Admin
		@users = User.all.order("sign_in_count DESC").paginate(:page => params[:page], :per_page => 10)
		@user_count = User.count(:all)
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  	@user = User.friendly.find(params[:id])
  end

  # GET /admins/new

end
