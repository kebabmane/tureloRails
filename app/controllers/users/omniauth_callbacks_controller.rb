class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

    def self.provides_callback_for(provider)
      class_eval %Q{
        def #{provider}
          @user = User.find_for_oauth(env["omniauth.auth"], current_user)

          if @user.persisted?
            sign_in_and_redirect @user, event: :authentication
            set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
          else
            session["devise.#{provider}_data"] = env["omniauth.auth"]
            redirect_to new_user_registration_url
          end
        end
      }
    end

    [:twitter, :facebook, :google_oauth2].each do |provider|
      provides_callback_for provider
    end

    def after_sign_in_path_for(resource)
      if resource.social_signup_done == false
        finish_signup_path(resource)
     else
        overviews_path
     end
   end


    def setup
        request.env['omniauth.strategy'].options['scope'] = flash[:scope] || request.env['omniauth.strategy'].options['scope']
        render :text => "Setup complete.", :status => 404
    end

end
