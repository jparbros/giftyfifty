class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :get_user
  
  def get_user
    if user_signed_in?
    else
      @user = User.new
    end
  end
end
