class SessionsController < ApplicationController
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid_provider(params[:provider],auth['uid'])
    user = User.create_by_provider(auth,params[:provider]) if user.blank?
    if (params[:gift_url] and params[:from_main] and !params[:gift_url].blank?) || session['gift_url']
      sign_in(:user, user)
      redirect_to redirect_to_event_path('gift_url' => params[:gift_url] || session['gift_url'])
    else
      sign_in_and_redirect(:user, user)
    end
  end
  
end
