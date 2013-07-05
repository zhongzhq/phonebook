class User < ActiveRecord::Base
  attr_accessible :account, :password, :name, :email, :phone, :membership_id, :organ_id

  validates_presence_of :account, :password, :email, :phone

  belongs_to :membership
end
