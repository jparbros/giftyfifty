# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110210120532) do

  create_table "addresses", :force => true do |t|
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "zip_code"
    t.boolean  "pobox"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "mobile_phone"
  end

  create_table "amazon_shipments", :force => true do |t|
    t.text     "category"
    t.integer  "per_shipment"
    t.integer  "per_item"
    t.integer  "location_id"
    t.boolean  "per_pound"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donations", :force => true do |t|
    t.integer  "donation"
    t.integer  "payment_fees"
    t.integer  "internal_fees"
    t.integer  "event_id"
    t.integer  "total"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "occasion_id"
    t.integer  "user_id"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
    t.date     "start_at"
    t.date     "end_at"
    t.boolean  "manual"
    t.string   "identifier"
    t.string   "state"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.text     "url"
    t.string   "cart_id"
    t.string   "cart_item_id"
    t.string   "item_id"
    t.integer  "event_id"
    t.text     "purchase_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url"
    t.string   "category"
    t.string   "image_uploaded"
    t.integer  "shipping_cost"
  end

  create_table "locations", :force => true do |t|
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauth_accounts", :force => true do |t|
    t.string   "token"
    t.string   "secret"
    t.integer  "user_id"
    t.integer  "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "type"
  end

  create_table "occasions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "releases", :force => true do |t|
    t.integer  "event_id"
    t.integer  "amount"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.date     "birthday"
    t.integer  "location_id"
    t.string   "gender"
    t.string   "username"
    t.string   "avatar"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
