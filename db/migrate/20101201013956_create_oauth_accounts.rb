class CreateOauthAccounts < ActiveRecord::Migration
  def self.up
    create_table :oauth_accounts do |t|
      t.integer :account_type
      t.string :token
      t.string :secret
      t.integer :user_id
      t.integer :uid      

      t.timestamps
    end
  end

  def self.down
    drop_table :oauth_accounts
  end
end
