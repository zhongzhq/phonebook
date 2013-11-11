class Common < ActiveRecord::Base
  attr_accessible :name, :phone
  validates :name, :phone, :uniqueness => true, :presence => true
end
