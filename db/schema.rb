# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20121027212637) do

  create_table "groups", :force => true do |t|
    t.integer  "keyword_id"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "help_items", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "keywords", :force => true do |t|
    t.string   "name"
    t.integer  "under"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "order_items", :force => true do |t|
    t.integer  "order_id"
    t.decimal  "price"
    t.integer  "product_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "quantity"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "total_price"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "purchased"
    t.float    "shipping_cost"
    t.string   "shipping_method"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.integer  "stock"
    t.boolean  "public"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.float    "weight"
    t.float    "height"
    t.float    "length"
    t.float    "width"
    t.integer  "rating",             :default => 0
    t.integer  "sale_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "sales", :force => true do |t|
    t.string   "name"
    t.float    "markdown"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_types", :force => true do |t|
    t.boolean  "products"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.boolean  "purchase"
    t.boolean  "products_edit"
    t.boolean  "products_quantity"
    t.boolean  "help_edit"
    t.string   "name"
    t.boolean  "users_list"
    t.boolean  "orders_list"
    t.boolean  "user_types_edit"
    t.boolean  "keywords_edit"
    t.boolean  "sales_edit"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "zipcode"
    t.string   "email_address"
    t.string   "hashed_password"
    t.string   "credit_card"
    t.string   "phone_number"
    t.integer  "user_type_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_salt"
    t.string   "state"
    t.string   "country"
  end

end
