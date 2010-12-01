class Event < ActiveRecord::Base
  
  #
  # Relations
  #
  has_one :item
  belongs_to :provider
  belongs_to :occasion
  belongs_to :user
  
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
  # Methods
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
