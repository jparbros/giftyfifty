class AddNamesToUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :name
    remove_column :users, :password
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end

  def self.down
    add_column :users, :name, :string
    add_column :users, :password, :string
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end
