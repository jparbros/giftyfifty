Giftyfifty::Application.routes.draw do
  devise_for :users
  
  root :to => "main#index" 
  
  resources :users
  
   resources :events, :except => [:index, :delete] do
      resource :twitter, :only => :create
      resource :facebook, :only => :create
      resources :donations, :only => [:new, :create, :show]
    end
  
  namespace :my_account do
    resource :main
    resource :twitter, :only => [:new, :show] do
      member do
        get 'create_twitter'
      end
    end
    resource :facebook, :only => [:new, :show] do
      member do
        get 'create_facebook'
      end
    end
  end
  
  
  
  
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/my_account/profile', :to => 'my_account/profile#show', :as => 'show_profile', :via => :get
  match '/my_account/profile', :to => 'my_account/profile#update', :as => 'update_profile', :via => :put
  match '/redirect', :to => 'main#redirect', :as => 'redirect_to_event', :via => :get
  match '/events/:event_id/donations/1/confirm', :to => 'donations#confirm', :as => 'confirm_donation', :via => :get
  match '/events/:event_id/donations/1/validate', :to => 'donations#validate', :as => 'validate_donation', :via => :post
  match '/my_account/profile', :to => 'my_account/profile#update', :as => 'update_profile', :via => :put
  match '/blank', :to => 'main#blank'
  match '/users', :to => 'devise/registrations#update', :via => :put
  match '/:user_name', :to => 'my_account/profile#show'
  match '/events/:event_id/twitter', :to => 'twitters#create'
  match '/events/:event_id/facebook', :to => 'facebooks#create'
  match '/locale/:locale', :to => 'main#set_locale', :as => 'set_locale'
end
