Rails.application.routes.draw do

  resources :announcements
  root to: 'landings#index'

  get 'tags/:tag', to: 'overviews#index', as: :tag
  get 'announcements/:id/hide', to: 'announcements#hide', as: 'hide_announcement'

  resources :feeds do
    resources :feed_entries do
      resources :feed_entry_images
    end
    post 'refresh_feed', :to=>"feeds#refresh_feed"
  end

  resources :overviews
  resources :first_signup

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

  get '/follow'     => 'feeds#follow'
  get '/unfollow'   => 'feeds#unfollow'
  get '/like'       => 'feed_entries#like'
  get '/unlike'     => 'feed_entries#unlike'


  namespace :turelo_admin do
    resources :admins
    resources :feeds
    resources :users
    resources :devices
    resources :announcements
  end



  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  namespace :api do
   namespace :v1 do
     devise_for :users, skip: :omniauth_callbacks, :controllers => { :sessions => "api/v1/sessions", :registrations => "api/v1/registration"}
       resources :feeds do
        collection do
         get :autocomplete
        end
       end
       resources :users
       resources :feed_search
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
