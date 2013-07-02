# encoding: UTF-8
ActiveRecord::Schema.define(:version => 20130617083036) do

  create_table "phonebooks", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
