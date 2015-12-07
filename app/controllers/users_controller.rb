class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
		@users = User.all.paginate(:page => params[:page], :per_page => 10)
		authorize User
  end

  def show
    @user = User.friendly.find(params[:id])
    authorize @user
  end

  def edit
      @user = current_user
  end

  def update
    @user = User.friendly.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role, :nickname, :time_zone)
  end


end
