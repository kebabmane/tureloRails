module Api
 module V1
   class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_action :verify_authenticity_token

  api!
  def create
    @user = User.new
    @user.nickname = params[:nickname]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save
      render :json=> {:auth_token=>@user.authentication_token, :email=>@user.email}, :status=>201
      return
    else
      warden.custom_failure!
      render :json=> @user.errors, :status=>422
    end
  end


  protected

  def invalid_login_attempt
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end

  def user_params

  end

    end
  end
end
