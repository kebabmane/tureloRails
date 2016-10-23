class Users::SessionsController < Devise::SessionsController
  skip_before_action :require_no_authentication, :only => [ :new, :create ]
  #skip_before_action :ensure_user_is_available


  def create
    self.resource = warden.authenticate!(auth_options)
    flash[:success] = "Welcome back, #{current_user.email}" if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

private


end
