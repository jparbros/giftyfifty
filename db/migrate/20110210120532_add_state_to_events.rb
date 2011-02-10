class AddStateToEvents < ActiveRecord::Migration
  def self.up
    remove_column :events, :open
    add_column :events, :state, :string
  end

  def self.down
    add_column :events, :open, :boolean
    remove_column :events, :state
  end
end
