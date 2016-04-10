class RegistrationsController < Devise::RegistrationsController
  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
      AdminMailer.new_user_waiting_for_approval(@user).deliver_later
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to @user
    else
      render "edit"
    end
  end

 def new
    build_resource({})
    yield resource if block_given?
    respond_with self.resource
  end

  def create
    super
  end


  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    user.email != params[:user][:email] ||
      params[:user][:password].present? ||
      params[:user][:password_confirmation].present?
  end

    def sign_up_params
    allow = [:email, :password, :password_confirmation, :nickname]
    params.require(resource_name).permit(allow)
  end

   def after_update_path_for(resource)
      user_path(resource)
    end

     def after_inactive_sign_up_path_for(resource)
    	'/thanks.html'
     end
end
