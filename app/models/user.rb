class User < ActiveRecord::Base
  attr_accessible :account, :password, :name, :email, :phone, :membership_id, :organ_id, :password_confirmation

  validates_presence_of :account, :password, :email, :phone
  has_secure_password
  
  belongs_to :membership
end
