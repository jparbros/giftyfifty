class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_user, :get_event_url, :redirect_to_new_event

  def get_event_url
    if params[:gift_url] and params[:from_main] and !params[:gift_url].blank?
      session['gift_url'] = params[:gift_url]
    end
  end
  
  def redirect_to_new_event
    if session['gift_url'] and current_user
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
