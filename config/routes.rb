Giftyfifty::Application.routes.draw do
  devise_for :users
  
  root :to => "main#index" 
  
  resources :events, :only => [:create, :new, :show, :edit, :update]
  
  namespace :my_account do
    resource :socials do
      member do
        get 'create_twitter'
        get 'new_twitter'
      end
    end
  end

  match '/login', :to => 'sessions#login', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create'
end
