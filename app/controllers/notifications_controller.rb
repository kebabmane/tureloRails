class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(recipient: current_user).unread
  end

  def mark_as_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end


  def send_gcm_notification notification
    if !Rpush::Gcm::App.find_by_name("quizzl-me")
      app = Rpush::Gcm::App.new
      app.name = "quizzl-me"
      app.auth_key = "AIzaSyDzb3DTBI2sIlamMYw-hJvdIrzFK5ok7mw"
      app.connections = 1
      app.save!
    end

    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name("quizzl-me")
    n.registration_ids = Device.all.map{|device| device.registration_id}
    message = notification.message
    n.data = notification.as_json
    n.save!
  end

  

end
