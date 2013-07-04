class Rank < ActiveRecord::Base
  attr_accessible :name

  has_many :organs
end
