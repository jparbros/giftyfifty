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
    resource :twitter do
      member do
        get 'create_twitter'
      end
    end
    resource :facebook do
      member do
        get 'create_facebook'
      end
    end
  end

  match '/auth/:provider/callback', :to => 'sessions#create'
end
