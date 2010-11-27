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
  
  def self.create_by_provider(provider_info,provider)
    password = generate_password
    user = self.new(:email => provider_info['extra']['user_hash']['email'], :password => password, :password_confirmation => password)
    user.save
    provider_params = case provider
    when 'twitter'
      {:account_type => 'Twitter', :token => provider_info['credentials']['token'], :secret =>provider_info['credentials']['secret']}
    when 'facebook'
      {:account_type => 'Facebook', :token => provider_info['credentials']['token']}
    end
    user.gateway.new_account(provider_params)
    user
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
  
  def self.generate_password(length = 10)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a + %w{$ | !}
    code = ""
    1.upto(length) { |i| code << chars[rand(chars.size-1)] }
    code
  end
end
