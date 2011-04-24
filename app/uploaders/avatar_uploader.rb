# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def cache_dir
    "#{Rails.root.to_s}/tmp/uploads"
  end

  #Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fill => [50, 50]
  end
    
  version :menu do
    process :resize_to_fill => [30, 30]
  end

end
