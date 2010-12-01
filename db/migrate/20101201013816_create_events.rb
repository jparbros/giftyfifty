class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :occasion_id
      t.integer :user_id
      t.integer :provider_id

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
