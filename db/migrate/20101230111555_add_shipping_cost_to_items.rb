class AddShippingCostToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :shipping_cost, :integer
  end

  def self.down
    remove_column :items, :shipping_cost
  end
end
