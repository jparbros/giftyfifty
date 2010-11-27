class MyAccount::SocialsController < ApplicationController
  before_filter :request_token, :only =>[:new_twitter]
  before_filter :authenticate_user!
  
  def show
    @accounts = current_user.gateway.all_accounts
  end
  
  def new_twitter
    redirect_to request_token.authorize_url
  end
  
  def create_twitter
    @access_token = client.authorize(
      request_token.token,
      request_token.secret,
      :oauth_verifier => params[:oauth_verifier])
    current_user.gateway.new_account({:account_type => 'Twitter', :token => @access_token.token ,:secret => @access_token.secret})
    redirect_to :action => :show
  end
  
  private
  
  def client
    @client ||= TwitterOAuth::Client.new(TWITTER_CREDENTIALS)
  end
  
  def request_token
    @request_token ||= session[:request_token] ||= client.request_token(:oauth_callback => create_twitter_my_account_socials_url)
  end
end
