class UserMailer < ActionMailer::Base
  default from: "app@turelo.me"

  def registration_confirmation(user)
    mail(:to => user.email, :subject => "Thanks for signing up", :from => "app@turelo.me")
  end

  def send_new_user_message(user)
  	mail(:to => user.email, :subject => "Thanks for signing up", :fromt => "app@turelo.me")
  end

  def password_changed id
    @user = User.find(id)
    mail to: @user.email, subject: "Your password has changed"
  end
end
