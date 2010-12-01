class AddPolymorphicToOauthAccounts < ActiveRecord::Migration
  def self.up
    add_column :oauth_accounts, :owner_type, :string
    add_column :oauth_accounts, :owner_id, :integer
    remove_column :oauth_accounts, :account_type
    add_column :oauth_accounts, :type, :string
  end

  def self.down
    remove_column :oauth_accounts, :type
    add_column :oauth_accounts, :account_type, :string
    remove_column :oauth_accounts, :owner_id
    remove_column :oauth_accounts, :owner_type
  end
end