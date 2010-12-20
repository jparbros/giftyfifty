class MyAccount::FacebooksController < ApplicationController
  
  def new
    redirect_to client.authorization.authorize_url(:redirect_uri => create_facebook_my_account_facebook_url , :scope => 'email,publish_stream')
  end
  
  def create_facebook
    begin
      access_token = client.authorization.process_callback(params[:code], :redirect_uri => create_facebook_my_account_facebook_url)
      current_user.facebook_account = FacebookAccount.new({:token => access_token})
      current_user.save
      message_output = 'Your facebook account was linked successfully.'
    rescue Exception => e
      message_output = 'There was a problem linking your facebook account.'
    end
    growl_message message_output
    redirect_to request.referrer
  end
  
  private
  
  def client
    @client ||= FBGraph::Client.new(FACEBOOK_CREDENTIAL)
  end
  
end
