# -*- coding: utf-8 -*-
class Address < ActiveRecord::Base
  attr_accessible :name, :phone

  has_and_belongs_to_many :members
end
