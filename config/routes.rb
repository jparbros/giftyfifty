Giftyfifty::Application.routes.draw do
  devise_for :users
  
  root :to => "main#index" 
  
  resources :events, :only => [:create, :new, :show, :edit, :update]

  match '/login', :to => 'sessions#login', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create'
end
