Rails.application.routes.draw do

  resources :categories
  root to: 'landings#index'


  get 'tags/:tag', to: 'overviews#index', as: :tag
  get 'popular_tags', to: 'feed_entries#popular_tags'
  get 'announcements/:id/hide', to: 'announcements#hide', as: 'hide_announcement'
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

resources :categories do
  resources :feeds do
    resources :feed_entries do
      resources :feed_entry_images
    end
    post 'refresh_feed', :to=>"feeds#refresh_feed"
  end
end

  resources :overviews
  resources :first_signup
  resources :announcements

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
    resources :categories
  end



  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  namespace :api do
   namespace :v1 do
       resources :feeds do
        collection do
         get :autocomplete
        end
       end
       resources :users
       resources :feed_search
       resources :devices
       resources :timelines
       resource :user
       devise_scope :user do
         post 'registrations' => 'registrations#create', :as => 'register'
         post 'sessions' => 'sessions#create', :as => 'login'
         delete 'sessions' => 'sessions#destroy', :as => 'logout'
       end
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
