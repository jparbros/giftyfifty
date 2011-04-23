class ApplicationController < ActionController::Base
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  include SslRequirement
  protect_from_forgery

  before_filter :get_user, :redirect_to_new_event, :initialize_growl, :locales

  private
    
  def redirect_to_new_event
    if session['gift_url'] and current_user and session['gift_url'] != 'Paste the URL of your Gift'
      gift_url = session['gift_url']
      session['gift_url'] = nil
      redirect_to redirect_to_event_path('gift_url' => gift_url)
    end
  end
  
  def get_user
    if user_signed_in?
      @user = current_user
    else
      @user = User.new
    end
  end
  
  protected
  
  def growl_message(message)
    session[:growl][:active] = true
    session[:growl][:message] = message
  end
  
  def initialize_growl
    if session[:growl].nil?
      session[:growl] = {}
      session[:growl][:active] = false
    end
  end
  
  def locales
    I18n.locale = session[:locale] || 'en'
  end
  
end
