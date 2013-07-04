class Rank < ActiveRecord::Base
  attr_accessible :name, :parent_id

  validates :name, presence: true, uniqueness: true

  has_many :childs, class_name: 'Organ', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Organ'

  has_many :organs
end
