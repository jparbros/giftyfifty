Giftyfifty::Application.routes.draw do
  devise_for :users
  
  root :to => "main#index" 
  
  resources :users do
    resources :events do
      resource :twitter
      resource :facebook
    end
  end
  
  namespace :my_account do
    resource :twitter
    resource :facebook
  end

  match '/auth/:provider/callback', :to => 'sessions#create'
end
