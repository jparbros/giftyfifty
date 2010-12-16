class Item < ActiveRecord::Base
  belongs_to :event
  
  mount_uploader :image_uploaded, ImageUploadedUploader
  
  def image
    self.image_url ? self.image_url : self.image_uploaded.url
  end
end
