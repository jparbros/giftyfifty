class MainController < ApplicationController
  def index; 
    render :layout => 'home'
  end
  
  def redirect; end
  
  def blank
    render :text => 'Success'
  end
  
  def set_locale
    session[:locale] = params[:locale]
    redirect_to request.referrer
  end
end
