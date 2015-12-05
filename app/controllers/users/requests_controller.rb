class Users::RequestsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]

  def index
    @requests = Request.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @users_inv_accepted = User.invitation_accepted
    @users_requesting_access = User.created_by_invite
    @users_not_accept_invite = User.invitation_not_accepted
    @all_requests = Request.all
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)

   respond_to do |format|
    if @request.save
      AdminMailer.new_user_waiting_for_approval(@request).deliver_later
      InvitationMailer.request_invite(@request).deliver_later
      format.html { redirect_to root_url }
      format.js
    else
      format.html { redirect_to root_url, notice: 'yeah look that didnt work' }
    end
  end
 end

  def invite
    request = Request.find(params[:id])
    User.invite!(:email => request.email)
    request.destroy
    redirect_to users_requests_url, :notice => "Invitation was sent"
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params
    params.require(:request).permit(:email)
  end

end
