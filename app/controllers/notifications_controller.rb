class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.includes(:actor).order("created_at DESC").where(recipient: current_user).page(params[:page]).per_page(10)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def mark_as_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end

end
