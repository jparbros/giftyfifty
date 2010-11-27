class SessionsController < ApplicationController
  #include Devise::Controllers::InternalHelpers 
  
  def create
    @auth = request.env["omniauth.auth"]
    
    @oauth_account = gateway.find_by_uid @auth['uid']
    unless @oauth_account.blank?
      user = User.find_by_user_id(@oauth_account['oauth_account']['user_id'])
      if user
        sign_in_and_redirect(:user, user)
      else
      end
    else
      user = User.create_by_provider(@auth,params[:provider])
      sign_in_and_redirect(:user, user)
    end
  end
  
end
