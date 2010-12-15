class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :country
      t.string :state
      t.string :city
      t.string :address_1
      t.string :address_2
      t.string :zip_code
      t.boolean :pobox
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
