class MyAccount::FacebooksController < ApplicationController
  
  def new
    redirect_to client.authorization.authorize_url(:redirect_uri => create_facebook_my_account_facebook_url , :scope => 'email,publish_stream')
  end
  
  def create_facebook
    access_token = client.authorization.process_callback(params[:code], :redirect_uri => create_facebook_my_account_facebook_url)
    current_user.facebook_account = FacebookAccount.new({:token => access_token})
    current_user.save
    redirect_to :action => :show
  end
  
  def show
    render :text => current_user.facebook_account
  end
  
  private
  
  def client
    @client ||= FBGraph::Client.new(FACEBOOK_CREDENTIAL)
  end
  
end
