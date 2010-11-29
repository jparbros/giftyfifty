class MyAccount::SocialsController < ApplicationController
  before_filter :request_token, :only =>[:new_twitter, :create_twitter]
  before_filter :facebook_client, :only => [:new_facebook, :create_facebook]
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
  
  def new_facebook
    redirect_to client.web_server.authorize_url(:redirect_uri => create_facebook_my_account_socials_url, :scope => 'email,user_photos,publish_stream')
  end
  
  def create_facebook
    access_token = client.web_server.get_access_token(params[:code], :redirect_uri => redirect_uri)  
    @user = JSON.parse(access_token.get('/me'))  
    #current_user.gateway.new_account({:account_type => 'Facebook', :token => @access_token.token ,:secret => @access_token.secret})
    render :text => @user.inspect
    #redirect_to :action => :show
  end
  
  private
  
  def client
    @client ||= TwitterOAuth::Client.new(TWITTER_CREDENTIALS)
  end
  
  def request_token
    @request_token ||= session[:request_token] ||= client.request_token(:oauth_callback => create_twitter_my_account_socials_url)
  end
  
  def facebook_client
    @facebook_client ||= OAuth2::Client.new('9265497607cecc1f3ee4877400859b89', '46c0ad920327791c06c2cd6713ea98c9', :site => 'https://graph.facebook.com')
  end
end
