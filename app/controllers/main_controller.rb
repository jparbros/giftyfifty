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
  
  def email
    render :text => "Test", :layout => 'email'
  end
  
  def login_box
    render :layout => false
  end
  
  def sign_box
    render :layout => false
  end
  
  def main_box
    render :layout => false
  end
end
