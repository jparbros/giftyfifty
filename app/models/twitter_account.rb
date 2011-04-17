class TwitterAccount < OauthAccount
  
  after_initialize :load_values
  
  def load_values
    @friends = []
  end
  
  def self.client
    @@client ||= TwitterOAuth::Client.new(TWITTER_CREDENTIALS)
  end
  
  def share(message)
    client.update(message)
  end
  
  def friends
    client.followers.each do |follower|
      @friends << Friend.new(:name => follower['name'], :social_id => follower['id'], :picture => follower['profile_image_url'], :social_type => 'twitter')
    end
    @friends
  end
  
  def client
    @client ||= TwitterOAuth::Client.new(
        TWITTER_CREDENTIALS.merge({
            :token => self.token,
            :secret => self.secret}))
  end
  
end