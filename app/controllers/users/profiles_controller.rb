class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
		@users = User.all.paginate(:page => params[:page], :per_page => 10)
		authorize User
  end

  def show
    @current_age = current_age
    @user = User.friendly.find(params[:id])
    @followed_feeds = current_user.followees(Feed)
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
      redirect_to :back, :notice => "yes, that worked"
    else
      redirect_to :back, :alert => "the cats broke something again..."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to munch_admin_admins_path, :notice => "poof - user is gone hey"
  end

  private

  def secure_params
    params.require(:user).permit(:role, :nickname, :time_zone, :approved)
  end

  def current_age
    now = Time.now.utc.to_date
    now.year rescue nil - current_user.date_of_birth.year - (current_user.date_of_birth.to_date.change(:year => now.year) > now ? 1 : 0)
  end

end
