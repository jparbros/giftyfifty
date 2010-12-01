class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.text :url
      t.string :cart_id
      t.string :cart_item_id
      t.string :item_id
      t.integer :event_id
      t.text :purchase_url
        
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
