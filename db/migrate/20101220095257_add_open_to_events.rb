class AddOpenToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :open, :boolean, :default => 1
  end

  def self.down
    remove_column :events, :open
  end
end
