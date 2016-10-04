class Users::SessionsController < Devise::SessionsController
  skip_before_action :require_no_authentication, :only => [ :new, :create ]
  #skip_before_action :ensure_user_is_available


  def new
    sign_out :user
    super
  end


private




end
