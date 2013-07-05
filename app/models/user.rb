class User < ActiveRecord::Base
  attr_accessible :account, :password, :name, :email, :phone, :membership_id, :organ_id, :password_confirmation, :status

  validates_presence_of :account, :password, :email, :phone, :password_confirmation
  has_secure_password
  
  belongs_to :membership
end
