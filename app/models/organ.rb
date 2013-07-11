# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  attr_accessible :name, :parent_id, :rank_id, :address, :description, :postalcode, :areacode, :status,:parent

  validates_presence_of :name, :rank_id

  belongs_to :rank

  has_ancestry

end
