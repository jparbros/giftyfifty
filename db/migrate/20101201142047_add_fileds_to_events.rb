class AddFiledsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :title, :string
    add_column :events, :description, :text
    add_column :events, :start_at, :timestamp
    add_column :events, :end_at, :timestamp
  end

  def self.down
    remove_column :events, :end_at
    remove_column :events, :start_at
    remove_column :events, :description
    remove_column :events, :title
  end
end
