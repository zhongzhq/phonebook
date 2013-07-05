class User < ActiveRecord::Base
  attr_accessible :account, :password, :name, :email, :phone, :membership_id, :organ_id
end
