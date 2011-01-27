class Friend < ActiveRecord::Base
  class_inheritable_accessor :columns
  
  def self.columns
    @columns ||= []
  end
 
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end
  
  belongs_to :user
 
  column :name, :string
  column :picture, :string
  column :social_id, :string
  column :social_type, :string
end