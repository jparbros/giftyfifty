class SessionsController < ApplicationController
  #include Devise::Controllers::InternalHelpers 
  
  def create
    auth = request.env["omniauth.auth"]
    
    user = User.find_by_uid_provider(auth['uid'])
    unless @user.blank?
      sign_in_and_redirect(:user, user)
    else
      user = User.create_by_provider(auth,params[:provider])
      sign_in_and_redirect(:user, user)
    end
  end
  
end
