class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.integer :event_id
      t.integer :amount
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :releases
  end
end
