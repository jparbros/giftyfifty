class ApplicationController < ActionController::Base
  include Facebooker2::Rails::Controller
  protect_from_forgery

  before_filter :get_user, :get_event_url, :get_recent_event

  def get_recent_event
    @event = session[:recent_event] if session[:recent_event]
  end

  def get_event_url
    if params['gift-url']
      session['gift-url'] = params['gift-url']
    end
  end

  def get_user
    if user_signed_in?
      @user = current_user
    else
      @user = User.new
    end
  end
  
  def get_api_authorization
    consumer_token = ConsumerToken.last
    api_gateway = Gifty::Api::Base.new
    api_gateway.user_id = self.id
    api_gateway.access_token= OAuth::AccessToken.from_hash(api_gateway.consumer, {:oauth_token => consumer_token.token,:oauth_token_secret => consumer_token.secret})
    @gateway = api_gateway
  end
  
  def gateway
    if current_user
      current_user.gateway
    else
      @gateway ||= get_api_authorization
    end
  end
  
end
