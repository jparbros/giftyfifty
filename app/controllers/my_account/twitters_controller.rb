class MyAccount::TwittersController < ApplicationController
  
  def new
    redirect_to request_token.authorize_url
  end
  
  def create_twitter
    access_token
    current_user.twitter_account = TwitterAccount.new({:token => access_token.token ,:secret => access_token.secret})
    current_user.save
    redirect_to :action => :show
  end
  
  def show
    render :text => current_user.twitter_account
  end
  
  private
  
  def client
    @client ||= TwitterOAuth::Client.new(TWITTER_CREDENTIALS)
  end
  
  def request_token
    @request_token ||= session[:request_token] ||= client.request_token(:oauth_callback => create_twitter_my_account_twitter_url)
  end
  
  def access_token
    @access_token ||= client.authorize(request_token.token, request_token.secret, :oauth_verifier => params[:oauth_verifier])
  end
end
