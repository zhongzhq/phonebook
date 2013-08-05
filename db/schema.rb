ActiveRecord::Schema.define(:version => 20130804032125) do

  create_table "actors", :force => true do |t|
    t.integer  "membership_id", :null => false
    t.integer  "organ_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actors_permissions", :force => true do |t|
    t.integer "permission_id", :null => false
    t.integer "actor_id", :null => false
  end

  create_table "actors_users", :force => true do |t|
    t.integer "user_id", :null => false
    t.integer "actor_id", :null => false
  end

  create_table "applies", :force => true do |t|
    t.integer  "user_id", :null => false
    t.integer  "actor_id", :null => false
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apply_organs", :force => true do |t|
    t.integer "user_id", :null => false
    t.string "organ_name", :null => false
    t.string "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.string   "name", :null => false
    t.integer  "organ_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organs", :force => true do |t|
    t.string   "name", :null => false
    t.string   "ancestry"
    t.text     "description"
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "permissions", :force => true do |t|
    t.string  "name", :null => false
    t.string  "code", :null => false
    t.string  "description"
    t.integer "level", :default => 1, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email", :null => false
    t.string   "encrypted_password", :null => false
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
