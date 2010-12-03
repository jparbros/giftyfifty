class CreateDonations < ActiveRecord::Migration
  def self.up
    create_table :donations do |t|
      t.integer :donation
      t.integer :payment_fees
      t.integer :internal_fees
      t.integer :event_id
      t.integer :total
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :donations
  end
end
