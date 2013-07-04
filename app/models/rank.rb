class Rank < ActiveRecord::Base
  attr_accessible :name, :parent_id

  validates :name, presence: true, uniqueness: true

  has_one :child, class_name: 'Rank', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Rank'

  has_many :organs
end
