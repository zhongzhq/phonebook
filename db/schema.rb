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

ActiveRecord::Schema.define(:version => 20131113085818) do
  execute "CREATE EXTENSION IF NOT EXISTS hstore"
  
  create_table "jobs", :force => true do |t|
    t.string  "name"
    t.string  "pinyin"
    t.integer "sort",   :default => 0
  end

  create_table "jobs_members", :force => true do |t|
    t.integer "job_id"
    t.integer "member_id"
  end

  create_table "members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organ_id"
    t.integer  "is_admin",   :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "organs", :force => true do |t|
    t.string   "name"
    t.string   "pinyin"
    t.string   "ancestry"
    t.string   "address"
    t.string   "phone"
    t.text     "comment"
    t.integer  "sort",       :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "properties", :force => true do |t|
    t.string "name"
    t.string "key"
    t.string "state"
  end

  create_table "systems", :force => true do |t|
    t.integer "login_remember_days"
    t.integer "page_num"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "pinyin"
    t.string   "account"
    t.string   "mobile_phone"
    t.string   "office_phone"
    t.string   "office_address"
    t.string   "password_digest"
    t.text     "authentication_token"
    t.string   "state"
    t.text     "comment"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.hstore   "properties"
  end

  add_index "users", ["properties"], :name => "index_users_on_properties"

end
