module Api
 module V1
  class NotificationsController < Api::BaseController


    def index
      @notifications = Notification.order("created_at DESC").where(recipient: current_user).all

      paginate json: @notifications
    end

    def mark_as_read
      @notifications = Notification.where(recipient: current_user).unread
      @notifications.update_all(read_at: Time.zone.now)
      render json: {success: true}
    end


  end
 end
end
