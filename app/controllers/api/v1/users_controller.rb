module Api
 module V1
  class UsersController < Api::BaseController
  before_filter :authenticate_user!

  respond_to :json

  api!
  def index
	   @users = User.where(id: current_user.id)
   end

   api!
   def show
     @wuser = Weight.find(params[:id])
   end



protected

  end
 end
end
