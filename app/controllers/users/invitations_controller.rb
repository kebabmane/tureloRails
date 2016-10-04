class Users::InvitationsController < Devise::InvitationsController
  skip_before_action :require_no_authentication, :only => [:edit, :update]



  def create
    current_user.sent_an_inviation
    super
  end


  def update_resource_params
    params.require(:user).permit(:email, :first_name, :last_name, :nickname, :password, :password_confirmation, :invitation_token)
  end


protected



end
