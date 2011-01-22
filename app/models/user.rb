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

  def self.create_by_provider(provider_info,provider)
    password = generate_password
    user = self.find_by_email(provider_info['extra']['user_hash']['email'] || '')
    unless user
      provider_name = provider_info['extra']['user_hash']['email'].split(' ')
      user = self.new(:email => provider_info['extra']['user_hash']['email'], :password => password, :password_confirmation => password, :first_name => provider_name.first, :last_name => provider_name.last)
      user.remote_avatar_url = provider_info['extra']['user_hash']['profile_image_url']
      user.save
    else
      return user
    end
    case provider
      when 'twitter'
        user.twitter_account = TwitterAccount.new({:token => provider_info['credentials']['token'], :secret =>provider_info['credentials']['secret']})
      when 'facebook'
        user.facebook_account = FacebookAccount.new({ :token => provider_info['credentials']['token']})
    end
    user
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
    self.first_name.to_s + ' ' + self.last_name.to_s
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
  
  private
  
  def self.generate_password(length = 10)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a + %w{$ | !}
    code = ""
    1.upto(length) { |i| code << chars[rand(chars.size-1)] }
    code
  end
end
