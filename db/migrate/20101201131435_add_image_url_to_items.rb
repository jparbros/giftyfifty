class AddImageUrlToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :image_url, :string
  end

  def self.down
    remove_column :items, :image_url
  end
end
