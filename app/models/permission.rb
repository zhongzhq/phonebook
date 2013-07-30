class Permission < ActiveRecord::Base
  attr_accessible :name, :action, :controller, :level

  validates :name, presence: true, :uniqueness => true
  validates_presence_of :action, :controller

  has_and_belongs_to_many :actors
end