# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  attr_accessible :name, :rank_id, :address, :description, :postalcode, :areacode, :status, :parent_id, :parent

  validates_presence_of :name, :rank_id

  belongs_to :rank

  has_many :actors
  has_ancestry
end
