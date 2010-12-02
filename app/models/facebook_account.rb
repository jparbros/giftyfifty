class FacebookAccount < OauthAccount
  def self.client
    @@client ||= FBGraph::Client.new(FACEBOOK_CREDENTIAL)
  end
  
  def client
    @client ||= FBGraph::Client.new(FACEBOOK_CREDENTIAL.merge({:token => self.token}))
  end
end