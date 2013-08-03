class Permission < ActiveRecord::Base
  attr_accessible :name, :code, :description, :level

  validates :name, :code, presence: true, :uniqueness => true
  validates :level, :inclusion => { :in => 0..1 }

  has_and_belongs_to_many :actors
end
