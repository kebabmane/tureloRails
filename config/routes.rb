Rails.application.routes.draw do
  root to: 'overviews#index'

  resources :users
  resources :feeds do
    resources :feed_entries
    post 'refresh_feed', :to=>"feeds#refresh_feed"
  end
  resources :overviews

  devise_for :users, :controllers => {
     :registrations =>         "users/registrations",
     :omniauth_callbacks =>    "users/omniauth_callbacks",
     :invitations   =>         "users/invitations",
     :sessions      =>         "users/sessions"
   }

  namespace :users do
    resources :profiles
    resources :requests, :only => [:index, :new, :create] do
       put :invite, :on => :member
     end
  end


  namespace :admin do
    resources :feeds
  end

   devise_scope :user do
    	get '/login' => 'devise/sessions#new'
    	get '/logout' => 'devise/sessions#destroy'
    end

    authenticate :user, lambda { |u| u.admin? } do
     require 'sidekiq/web'
     mount Blazer::Engine,  at: "admins/blazer"
     mount Sidekiq::Web,    at: 'admins/sidekiq'
    end
end
