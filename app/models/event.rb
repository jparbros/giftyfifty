class Event < ActiveRecord::Base
  
  #
  # Associations
  #
  has_many :donations
  has_one :item
  has_one :release
  belongs_to :provider
  belongs_to :occasion
  belongs_to :user
  
  #
  # Nested Attributtes
  #
  accepts_nested_attributes_for :item

  #
  # Accessors
  #
  attr_accessor :url
  
  #
  # Scopes
  #
  scope :active, where(:state => :active)
  scope :new_events, where(:state => :new)

  #
  # Callbacks
  #
  after_create :create_event, :create_url
  
  #
  # Constants
  #
  SOCIAL_MESSAGE = "Hey!!, looks my gift to my /OCCASION/ in GiftyFifty.com, /GIFT_URL/"
  SHARE_MESSAGE = "I donated to this gift /GIFT_URL/, hurry up and donate you too."
  
  state_machine :state, :initial => :new do
    state :new
    state :active
    state :completed
    state :archived
    
    event :activate do
      transition :new => :active
    end
    
    event :complete do
      transition :active => :completed
    end
    
    event :archive do
      transition :completed => :archived
    end
  end
  
  #
  # Instances Methods
  #

  def share_on_twitter(twitter_message)
    self.user.twitter_account.client.update(twitter_message)
  end
  
  def share_on_facebook(facebook_message)
    client = self.user.facebook_account.client
    user = client.selection.me.info!
    client.selection.user(user[:id]).feed.publish!(:message => facebook_message)
  end
  
  def message(message_type, message_url)
    case message_type
    when 'share'
      self.share_message(message_url)
    when 'event'
      self.social_message(message_url)
    end
  end
  
  def share_message(message_url)
    SHARE_MESSAGE.gsub('/GIFT_URL/', message_url)
  end
  
  def social_message(message_url)
    SOCIAL_MESSAGE.gsub('/GIFT_URL/', message_url).gsub('/OCCASION/',(self.occasion)? self.occasion.name.humanize : '' )
  end
  
  def total_donations
    self.donations.sum(:total)
  end
  
  def porcentage_donation
    if self.total_donations > 0
      ((self.total_donations * 100)/self.item.price)
    else
      0
    end
  end

  def rest_days
    (self.end_at)? (self.end_at - Time.now.to_date).to_i : 0
  end
  
  def print_rest_days
    if rest_days > 0
      "#{rest_days} days"
    else
      "Finished"
    end
  end
  
  def active
    ((self.start_at || Time.now.to_date) < Time.now.to_date) and ((self.end_at || Time.now.to_date) > Time.now.to_date)
  end
  
  def donations_completed?
    completed! if total_donations >= item.total
  end
  
  def total
    (price + shipping_cost)
  end
  
  def formated_price
    (total/100)
  end

  #
  # Private Methods
  #
  private

  def scrap_store
    case @provider.name
    when 'amazon'
      @item_info = Scrap::Amazon.new(self.url)
    when 'ebay'
      @item_info = Scrap::Ebay.new(self.url)
    end
    create_item
  end
  
  def parse_url
    self.url = URI.parse(self.url)
    @provider = :amazon if self.url.host.include? 'amazon'
    @provider = :ebay if self.url.host.include? 'ebay'
  end
  
  def create_item
    item = self.item= Item.new(
      :name => @item_info.name,
      :price => ((@item_info.price) * 100),
      :item_id => @item_info.asin,
      :purchase_url => self.url.to_s,
      :image_url => @item_info.image,
      :category => @item_info.category,
      :shipping_cost => calculate_shipping,
      :event => self)
    item.save
    item
  end
  
  def get_category
    case @item_info.category
    when 'Computer & Accessories'
      'Computers'
    else
      @item_info.category
    end
  end
  
  def calculate_shipping
    case @provider.name
    when 'amazon'
      amazon_shipment = AmazonShipment.find_by_category(get_category)
      if amazon_shipment
        if amazon_shipment.per_pound
          (amazon_shipment.per_shipment + (amazon_shipment.per_item * @item_info.weight))
        else
          (amazon_shipment.per_shipment + amazon_shipment.per_item)
        end
      else
        0
      end
    when 'ebay'
      @item_info.shipping.gsub('$','').to_f * 100
    end
  end
  
  def create_event
    unless self.manual
      parse_url
      self.provider = Provider.find_by_name(@provider.to_s)
      self.save
      scrap_store
    else
      self.item.price = self.item.price * 100
      self.item.save
    end
  end
  
  def create_url
    new_url = generate_url
    until Event.find_by_identifier(new_url).nil?
      new_url = generate_url
    end
    self.identifier = new_url
    self.save
  end
  
  def generate_url(length = 6)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a + %w{$ | !}
    code = ""
    1.upto(length) { |i| code << chars[rand(chars.size-1)] }
    code
  end
  
end
