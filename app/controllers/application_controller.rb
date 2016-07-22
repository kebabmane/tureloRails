class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Pundit
  before_filter :authenticate_user!
  around_filter :user_time_zone, if: :current_user
  #around_filter :with_timezone
  before_filter :set_last_seen_at, if: proc { user_signed_in? }
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
  acts_as_token_authentication_handler_for User, fallback_to_devise: false
  before_filter :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
       overviews_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  protected

    def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :nickname, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache) }
     devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :nickname, :email, :password, :remember_me) }
     devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:slug, :date_of_birth, :home_page, :user_description, :first_name, :last_name, :nickname, :current_password, :password, :password_confirmation, :time_zone, :is_female, :user_height, :avatar, :avatar_cache) }
     devise_parameter_sanitizer.for(:accept_invitation) do |u| u.permit(:first_name, :last_name, :phone, :password, :password_confirmation, :invitation_token)
    end
    end

    def set_last_seen_at
    	current_user.update_attribute(:last_seen_at, Time.now)
    end

    def user_time_zone(&block)
      Time.use_zone(current_user.time_zone, &block)
    end

    def with_timezone
      timezone = Time.find_zone(cookies[:timezone])
      Time.use_zone(timezone) { yield }
    end

    def user_not_authorized
      flash[:error] = "well that was naughty, dont worry we wont tell anyone"
      redirect_to request.headers["Referer"] || overviews_path
    end

end
