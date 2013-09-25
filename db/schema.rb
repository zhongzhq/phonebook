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

ActiveRecord::Schema.define(:version => 20130805124831) do

  create_table "memberships", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organs", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "ancestry"
    t.text     "description"
    t.string   "state"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "actors", :force => true do |t|
    t.integer  "membership_id", :null => false
    t.integer  "organ_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end















  create_table "actors_permissions", :force => true do |t|
    t.integer "permission_id", :null => false
    t.integer "actor_id",      :null => false
  end

  create_table "actors_users", :force => true do |t|
    t.integer "user_id",  :null => false
    t.integer "actor_id", :null => false
  end


  create_table "organ_applies", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "organ_name", :null => false
    t.text     "description"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end


  create_table "permissions", :force => true do |t|
    t.string  "name",                       :null => false
    t.string  "code",                       :null => false
    t.string  "description"
    t.integer "level",       :default => 1, :null => false
  end

  create_table "user_applies", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "actor_id",   :null => false
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email",                  :null => false
    t.string   "encrypted_password",     :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
