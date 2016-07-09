class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.includes(:actor).order("created_at DESC").where(recipient: current_user).limit(10)
  end

  def mark_as_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end

end
