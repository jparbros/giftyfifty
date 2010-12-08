class AddManualToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :manual, :boolean
  end

  def self.down
    remove_column :events, :manual
  end
end
