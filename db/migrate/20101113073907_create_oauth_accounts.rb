class CreateOauthAccounts < ActiveRecord::Migration
  def self.up
    create_table :oauth_accounts do |t|
      t.integer :account_type
      t.string :name
      t.string :password
      t.string :consumer_key
      t.string :consumer_secret
      t.string :token
      t.string :secret
      t.boolean :is_default
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :oauth_accounts
  end
end
