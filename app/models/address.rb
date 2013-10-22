# -*- coding: utf-8 -*-
class Address < ActiveRecord::Base
  attr_accessible :name, :phone
  validates :name, :presence => true, :uniqueness => true

  has_many :users
end
