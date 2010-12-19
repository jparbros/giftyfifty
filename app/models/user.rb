class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :address, :name, :username, :gender, :birthday, :address_attributes, :avatar, :avatar_cache
  
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

  def self.create_by_provider(provider_info,provider)
    password = generate_password
    user = self.find_by_email(provider_info['extra']['user_hash']['email'] || '')
    unless user
      user = self.new(:email => provider_info['extra']['user_hash']['email'] || "user_#{Time.now.to_i}@giftyfifty.com", :password => password, :password_confirmation => password)
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
    self.avatar.menu.url if self.avatar
  end
  
  def thumb_image
    self.avatar.thumb.url if self.avatar
  end
  
  def age
    today = Time.now
    bday = self.birthday
    (today.year - bday.year) - (today.yday < bday.yday ? 1 : 0)
  end
  
  private
  
  def self.generate_password(length = 10)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a + %w{$ | !}
    code = ""
    1.upto(length) { |i| code << chars[rand(chars.size-1)] }
    code
  end
end
