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

ActiveRecord::Schema.define(:version => 20131028085249) do

  create_table "commons", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "follows", :force => true do |t|
    t.integer  "user_id"
    t.integer  "followed_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.integer  "sort"
    t.string   "pinyin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "jobs_members", :force => true do |t|
    t.integer "job_id"
    t.integer "member_id"
  end

  create_table "members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organ_id"
    t.integer  "is_admin", :default => 0  # 默认 0 不是管理员
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "organs", :force => true do |t|
    t.string   "name"
    t.string   "ancestry"
    t.string   "address"
    t.string   "phone"
    t.text     "description"
    t.integer  "sort", :default => 0
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "recents", :force => true do |t|
    t.integer  "user_id"
    t.integer  "recently_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "settings", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.string   "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "account"
    t.string   "phone"
    t.string   "password_digest"
    t.text     "authentication_token"
    t.string   "state"
    t.text     "comment"
    t.string   "pinyin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.hstore   "properties"
  end

  add_index "users", ["properties"], :name => "index_users_on_properties"

  create_table "user_properties", :force => true do |t|
    t.string   "key"
    t.string   "name"
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end
end
