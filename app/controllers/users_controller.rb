class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized, except: :finish_signup

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
    authorize @user
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
    @user = User.find(params[:id])
    authorize @user
    @user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  # GET/PATCH /users/:id/finish_signup
def finish_signup
  @user = User.friendly.find(params[:id])
  if request.patch? && params[:user]
    if @user.update_attributes(secure_params)
      sign_in(@user, :bypass => true)
      @user.social_signup_done = 1
      @user.save
      redirect_to overviews_path notice: 'Your profile was successfully updated.'
    else
      @show_errors = true
    end
  end
end

  private

  def secure_params
    params.require(:user).permit(:role, :nickname, :time_zone, :email)
  end


end
