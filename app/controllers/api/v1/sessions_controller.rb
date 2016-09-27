module Api
 module V1
   class SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [:create ]
  before_action :ensure_params_exist

  respond_to :json
  skip_before_filter :verify_authenticity_token


  def_param_group :login_detail do
        param :login, String, "can be nickname or email address", :required => true
        param :password, String, "user password", :required => true
  end

  def_param_group :user_logout_detail do
        param :email, String, "can be nickname or email address", :required => true
  end

  api :POST, "/api/users/sign_in/", "create session / login user, will return API Token for user when succesful"
  param_group :login_detail
  def create
    resource = User.find_for_database_authentication(:login => params[:login])
    return invalid_login_attempt unless resource


    if resource.valid_password?(params[:password])
      sign_in("user", resource)
      resource.ensure_authentication_token
      render :json=> {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email}
      return
    end
    invalid_login_attempt
  end

  api :POST, "/api/users/sign_out/", "log user out, destroy session"
  param_group :user_logout_detail
  def destroy
    sign_out(resource_name)
  end

  protected
  def ensure_params_exist
    return unless params[:login].blank?
    render :json=>{:success=>false, :message=>"missing user_login parameter"}, :status=>422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"error with your login or password"}, :status=>401
  end

  def user_login_params
    params.require(:login_details).permit(:login, :password)
  end


    end
  end
end
