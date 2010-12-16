class AddImageUploadedToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :image_uploaded, :string
  end

  def self.down
    remove_column :items, :image_uploaded
  end
end
