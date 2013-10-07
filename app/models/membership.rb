# -*- coding: utf-8 -*-
class Membership < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true

  has_many :actors
end
