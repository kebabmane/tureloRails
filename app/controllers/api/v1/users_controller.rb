module Api
 module V1
  class UsersController < Api::BaseController
  before_action :authenticate_user!

  respond_to :json


  def index
	   @users = User.where(id: current_user.id)
  end

  def show
     render :json => {:user => current_user}, :status => 200
     #@user = User.where(user_id: current_user.id)
  end


  end
 end
end
