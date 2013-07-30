class Permission < ActiveRecord::Base
  attr_accessible :name, :action, :subject_class, :level

  validates :name, presence: true, :uniqueness => true
  validates_presence_of :action, :subject_class

  has_and_belongs_to_many :actors
end