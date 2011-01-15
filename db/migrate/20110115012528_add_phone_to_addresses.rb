class AddPhoneToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :phone, :string
    add_column :addresses, :mobile_phone, :string
  end

  def self.down
    remove_column :addresses, :mobile_phone
    remove_column :addresses, :phone
  end
end
