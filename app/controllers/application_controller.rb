class ApplicationController < ActionController::Base
  include SslRequirement
  protect_from_forgery

  before_filter :get_user, :get_event_url, :redirect_to_new_event, :initialize_growl, :locales

  private
  
  def get_event_url
    if params[:gift_url] and params[:from_main] and !params[:gift_url].blank?
      session['gift_url'] = params[:gift_url]
    end
  end
  
  def redirect_to_new_event
    puts "dddddd"
    puts (session['gift_url'] and current_user and session['gift_url'] != 'Paste the URL of your Gift').to_s
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
