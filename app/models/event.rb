class Event < ActiveRecord::Base
  
  #
  # Associations
  #
  has_many :donations
  has_one :item
  belongs_to :provider
  belongs_to :occasion
  belongs_to :user
  
  #
  # Nested Attributtes
  #

  accepts_nested_attributes_for :occasion

  #
  # Accessors
  #
  attr_accessor :url

  #
  # Callbacks
  #
  after_create :create_event
  
  #
  # Constants
  #
  SOCIAL_MESSAGE = "Hey!!, looks my gift to my /OCCASION/ in GiftyFifty.com, /GIFT_URL/"
  SHARE_MESSAGE = "I donated to this gift /GIFT_URL/, hurry up and donate you too."
  
  #
  # Instances Methods
  #

  def share_on_twitter(event_url, message)
    self.user.twitter_account.client.update(message(message, event_url))
  end
  
  def share_on_facebook(event_url, message)
    client = self.user.facebook_account.client
    user = client.selection.me.info!
    client.selection.user(user[:id]).feed.publish!(:message => message(message, event_url) )
  end
  
  def message(message_type, message_url)
    case message_type
    when 'share'
      SHARE_MESSAGE.gsub('/GIFT_URL/', event_url)
    when 'event'
      SOCIAL_MESSAGE.gsub('/GIFT_URL/', event_url).gsub('/OCCASION/',self.occasion.name.humanize)
    end
  end
  
  def total_donations
    self.donations.sum(:total)
  end
  
  def porcentage_donation
    ((self.total_donations * 100)/self.item.price)
  end

  def rest_days
    Time.at(self.end_at - Time.now).day if self.end_at
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
    puts @provider
  end
  
  def create_item
    item = self.item= Item.new(
      :name => @item_info.name,
      :price => ((@item_info.price) * 100),
      :item_id => @item_info.asin,
      :purchase_url => self.url.to_s,
      :image_url => @item_info.image,
      :event => self)
    item.save
    item
  end
  
  def create_event
    parse_url
    self.provider = Provider.find_by_name(@provider.to_s)
    self.save
    scrap_store
  end
  
end
