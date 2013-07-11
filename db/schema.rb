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

ActiveRecord::Schema.define(:version => 20130617083036) do

  create_table "organs",:force => true do |t|
    t.string :name
    t.integer :parent_id
    t.integer :rank_id

    t.string :address
    t.text :description
    t.integer :postalcode
    t.string :areacode

    t.integer :status,:default => 0 #默认 0禁用 1启用

    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ranks", :force => true do |t|
    t.string :name
    t.integer :parent_id
    # t.integer :level ,:defaut=>1 # 1企业级 0系统级

    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "memberships", :force => true do |t|
    t.string :name
    t.integer :status, :default => 0 # 0企业用户 1系统用户

    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "actors", :force => true do |t|
    t.integer :membership_id
    t.integer :organ_id

    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "actors_users", :force => true do |t|
    t.integer :user_id
    t.integer :actor_id
  end

  create_table "users", :force => true do |t|
    t.string :account
    t.string :name
    t.string :phone

    t.integer :status, :default => 0 # 默认 0 未激活 1 激活

    ## devise field
    # Database authenticatable
    t.string :email,              :null => false, :default => ""
    t.string :encrypted_password, :null => false, :default => ""

    # Recoverable
    t.string   :reset_password_token
    t.datetime :reset_password_sent_at

    # Confirmable
    t.string   :confirmation_token
    t.datetime :confirmed_at
    t.datetime :confirmation_sent_at
    t.string   :unconfirmed_email

    # Token authenticatable
    t.string :authentication_token

    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end


  create_table "phonebooks", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
