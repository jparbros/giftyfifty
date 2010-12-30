class AddIdentifierToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :identifier, :string
  end

  def self.down
    remove_column :events, :identifier
  end
end
