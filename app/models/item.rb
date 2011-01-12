class Item < ActiveRecord::Base
  belongs_to :event
  
  mount_uploader :image_uploaded, ImageUploadedUploader
  
  def image
    self.image_url ? self.image_url : self.image_uploaded.url
  end
  
  def formated_price
    (((self.price || 0) + (self.shipping_cost || 0))/100)
  end
  
  def formated_shipping_cost
    ((self.shipping_cost || 0)/100)
  end
  
end
