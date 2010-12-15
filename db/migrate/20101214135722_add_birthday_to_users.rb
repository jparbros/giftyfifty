class AddBirthdayToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :birthday, :date
    add_column :users, :location_id, :integer
    add_column :users, :gender, :string
    add_column :users, :username, :string
  end

  def self.down
    remove_column :users, :username
    remove_column :users, :gender
    remove_column :users, :location_id
    remove_column :users, :birthday
  end
end
