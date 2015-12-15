Rails.application.routes.draw do

  root to: 'landings#index'

  resources :feeds do
    resources :feed_entries do
      resources :feed_entry_images
    end
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

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

   devise_scope :user do
    	get '/login' => 'devise/sessions#new'
    	get '/logout' => 'devise/sessions#destroy'
    end

    authenticate :user, lambda { |u| u.admin? } do
     require 'sidekiq/web'
     require 'sidekiq/cron/web'
     mount Blazer::Engine,    at: "admins/blazer"
     mount Sidekiq::Web,      at: 'admins/sidekiq'
     mount Searchjoy::Engine, at: "admins/searchjoy"
     mount PgHero::Engine,    at: "admins/pghero"
    end
end
