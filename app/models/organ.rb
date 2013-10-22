# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  attr_accessible :ancestry, :description, :name, :sort

   has_many :members
end
