class Membership < ActiveRecord::Base
  attr_accessible :name,:status

  validates_presence_of :name

  has_many :users
end
