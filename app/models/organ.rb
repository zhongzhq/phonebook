class Organ < ActiveRecord::Base
  attr_accessible :name, :parent_id, :rank_id, :address, :description, :postalcode, :areacode, :status

  validates_presence_of :name, :rank_id

  has_many :childs, class_name: 'Organ', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Organ'

  belongs_to :rank
end
