class ChangeTimesFieldsToEvents < ActiveRecord::Migration
  def self.up
    change_column :events, :start_at, :date
    change_column :events, :end_at, :date
  end

  def self.down
    change_column :events, :start_at, :timestamp
    change_column :events, :end_at, :timestamp
  end
end