class TwitterAccount < OauthAccount
  
  def self.client
    @@client ||= TwitterOAuth::Client.new(TWITTER_CREDENTIALS)
  end
  
  def client
    @client ||= TwitterOAuth::Client.new(
        TWITTER_CREDENTIALS.merge({
            :token => self.token,
            :secret => self.secret}))
  end
  
end