class Users::RegistrationsController < Devise::RegistrationsController
before_filter :configure_permitted_parameters

 def new
    build_resource({})
    yield resource if block_given?
    respond_with self.resource
  end

  def create
    super
  end


  protected

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    user.email != params[:user][:email] ||
      params[:user][:password].present? ||
      params[:user][:password_confirmation].present?
  end

  def sign_up_params
    allow = [:email, :password, :password_confirmation, :nickname, :first_name, :last_name, :date_of_birth, :time_zone]
    params.require(resource_name).permit(allow)
  end

  def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :nickname, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache) }
   devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :nickname, :email, :password, :remember_me) }
   devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:slug, :date_of_birth, :home_page, :user_description, :first_name, :last_name, :nickname, :current_password, :password, :password_confirmation, :time_zone, :is_female, :user_height, :description, :avatar, :avatar_cache) }
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    overviews_path
  end

  def after_sign_up_path_for(resource)
    first_signup_path(:first_sign_up_detail)
  end

  def after_inactive_sign_up_path_for(resource)
    first_signup_path(:first_sign_up_detail)
  end

end
