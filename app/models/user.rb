class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :address, :first_name, :last_name, :username, :gender, :birthday, :address_attributes, :avatar, :avatar_cache
  
  #
  # Uploader
  #
  mount_uploader :avatar, AvatarUploader
  
  #
  # Associations
  #
  has_many :donations
  has_many :consumer_tokens
  has_many :events
  has_one :twitter_account, :as => :owner
  has_one :facebook_account, :as => :owner
  has_one :address
  
  #
  # Nested Attributtes
  #
  accepts_nested_attributes_for :address
  
  #
  # Scopes
  #
  scope :by_facebook_uid, lambda {|uid| joins(:facebook_account).where('oauth_accounts.uid' => uid) }
  scope :by_twitter_uid, lambda {|uid| joins(:twitter_account).where('oauth_accounts.uid' => uid) }
  
  #
  # Callbacks
  #
  
  after_create :create_address
  after_initialize :load_values
  
  def load_values
    @twitter_friends = []
    @facebook_friends = []
  end

  def self.create_by_provider(provider_info,provider)
    password = generate_password
    user = self.find_by_email(provider_info['extra']['user_hash']['email'] || '')
    unless user
      provider_name = provider_info['extra']['user_hash']['name'].split(' ')
      user = self.new(:email => provider_info['extra']['user_hash']['email'] || ' ', :password => password, :password_confirmation => password, :first_name => provider_name.first, :last_name => provider_name.last)
      user.remote_avatar_url = provider_info['extra']['user_hash']['profile_image_url']
      user.save
    else
      return user
    end
    case provider
      when 'twitter'
        user.twitter_account = TwitterAccount.new({:token => provider_info['credentials']['token'], :secret =>provider_info['credentials']['secret']})
        get_avatar(user, provider_info['extra']['user_hash']['profile_image_url'])
      when 'facebook'
        user.facebook_account = FacebookAccount.new({ :token => provider_info['credentials']['token']})
        get_facebook_avatar(user)
    end
    user
  end
  
  def self.get_facebook_avatar(user)
    id = user.facebook_client.selection.me.info!.id
    res = open("http://graph.facebook.com/#{id}/picture?type=large")
    get_avatar(user, res.base_uri.to_s)
  end
  
  def self.get_avatar(user, image_url)
    user.remote_avatar_url = image_url
    user.save
  end
  
  def self.find_by_uid_provider(provider, uid)
    case provider
    when 'twitter'
      self.by_twitter_uid(uid)
    when 'facebook'
      self.by_facebook_uid(uid)
    end
  end
  
  def create_address
    address = self.build_address
    address.save
  end
  
  def name
    if first_name.blank? and last_name.blank?
      'Welcome'
    else
      first_name.to_s + ' ' + last_name.to_s
    end
  end
  
  def password_required? 
    new_record? 
  end
  
  def update_with_password(params={})
    current_password = params.delete(:current_password)
    
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    
    current_password.blank?

    result = if valid_password?(current_password) or current_password.blank?
      update_attributes(params)
    else
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      self.attributes = params
      false
    end

    clean_up_passwords
    result
  end
  
  def valid_to_donate?(password,email)
    valid_password?(password) and self.email == email
  end
  
  def active_event
    events.active
  end
  
  def menu_image
    if self.avatar.menu.url
      self.avatar.menu.url
    else
      'avatar-30.jpg'
    end
  end
  
  def thumb_image
    if self.avatar.thumb.url
      self.avatar.thumb.url
    else
      'avatar-50.jpg'
    end
  end
  
  def age
    if self.birthday
      today = Time.now
      bday = self.birthday
      (today.year - bday.year) - (today.yday < bday.yday ? 1 : 0)
    end
  end
  
  def profile_copleted?
    !first_name.nil? && !last_name.nil? && !birthday.nil? && !username.nil? && !email.nil? && address.completed? && !first_name.blank? && !last_name.blank? && !birthday.blank? && !username.blank? && !email.blank?
  end
  
  def facebook_client
    self.facebook_account.client
  end
  
  def twitter_client
    self.twitter_account.client
  end
  
  def facebook_friends
    if facebook_account and @facebook_friends.empty?
      facebook_client.selection.me.friends.info!.data.each do |friend|
        @facebook_friends << Friend.new(:name => friend.name, :social_id => friend.id, :picture => "http://graph.facebook.com/#{friend.id}/picture", :social_type => 'facebook')
      end
    end
    return @facebook_friends
  end
  
  def twitter_friends
    if twitter_account and @twitter_friends.empty?
      twitter_client.followers.each do |follower|
        @twitter_friends << Friend.new(:name => follower['name'], :social_id => follower['id'], :picture => follower['profile_image_url'], :social_type => 'twitter')
      end
    end
    return @twitter_friends
  end
  
  private
  
  def self.generate_password(length = 10)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a + %w{$ | !}
    code = ""
    1.upto(length) { |i| code << chars[rand(chars.size-1)] }
    code
  end
end
