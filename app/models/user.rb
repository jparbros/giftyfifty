class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :consumer_tokens
  
  after_create :create_consumer_token
  after_initialize :load_token
  
  def load_token
    unless consumer_tokens.blank?
      @gateway = Gifty::Api::Base.new
      @gateway.user_id = self.user_id
      @gateway.access_token= OAuth::AccessToken.from_hash(@gateway.consumer, {:oauth_token => consumer_tokens.last.token,:oauth_token_secret => consumer_tokens.last.secret})
    end
  end
  
  def gateway
    @gateway
  end
  
  private
  
  def create_consumer_token
    if consumer_tokens.blank?
      @gateway = Gifty::Api::Base.new
      @gateway.consumer
      @gateway.request_token_authorized
      @gateway.access_token
      self.consumer_tokens.create(:token => @gateway.access_token.token, :secret => @gateway.access_token.secret, :type => 'AccessToken')
      send_to_api
    end
  end
  
  def send_to_api
    user = @gateway.new_user({:email => self.email, :password => self.password, :password_confirmation => self.password_confirmation})
    self.user_id = user['user']['id']
    self.save
  end
end
