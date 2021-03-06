class AdminMailer < ActionMailer::Base
  default from: "app@turelo.me"

  def registration_confirmation(user)
    mail(:to => user.email, :subject => "Registered", :from => "app@turelo.me")
  end

  def new_user_waiting_for_approval(user)
  	mail(:to => "rhys@hannah-co.com", :subject => " New User Registered", :from => "app@turelo.me")
  end

end
