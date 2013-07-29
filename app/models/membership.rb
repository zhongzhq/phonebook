# -*- coding: utf-8 -*-
class Membership < ActiveRecord::Base
  attr_accessible :name, :organ_id

  validates :name, :organ_id, presence: true
  validates_existence_of :organ_id

  belongs_to :organ
  has_many :actors
end