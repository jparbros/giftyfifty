Giftyfifty::Application.routes.draw do
  devise_for :users
  
  root :to => "main#index" 
  
  resources :users
  
   resources :events, :except => [:index, :delete] do
      resource :twitter, :only => :create
      resource :facebook, :only => :create
      resources :donations, :only => [:new, :create, :show] do
        member do
          get 'confirm'
          post 'validate'
        end
      end
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
end
