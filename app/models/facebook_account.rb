class FacebookAccount < OauthAccount
  
  after_initialize :load_values
  
  def load_values
    @friends = []
  end
  
  def friends
    client.selection.me.friends.info!.data.each do |friend|
      @friends << Friend.new(:name => friend.name, :social_id => friend.id, :picture => "http://graph.facebook.com/#{friend.id}/picture", :social_type => 'facebook')
    end
    @friends
  end
  
  def share(message)
    client.selection.me.feed.publish!(:message => message)
  end
  
  def self.client
    @@client ||= FBGraph::Client.new(FACEBOOK_CREDENTIAL)
  end
  
  def client
    @client ||= FBGraph::Client.new(FACEBOOK_CREDENTIAL.merge({:token => self.token}))
  end
end