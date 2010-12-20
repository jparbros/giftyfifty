class MyAccount::ProfileController < ApplicationController
  before_filter :authenticate_user!, :except => :search
  
  def show
    
  end
  
  def search
    user = User.find_by_username(params[:user_name])
    if user
      event = user.events.active.last
      redirect_to event_path(event)
    else
      redirect_to :root
    end
  end
end
