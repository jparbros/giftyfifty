class CreateAmazonShipments < ActiveRecord::Migration
  def self.up
    create_table :amazon_shipments do |t|
      t.text :category
      t.integer :per_shipment
      t.integer :per_item
      t.integer :location_id
      t.boolean :per_pound

      t.timestamps
    end
  end

  def self.down
    drop_table :amazon_shipments
  end
end
