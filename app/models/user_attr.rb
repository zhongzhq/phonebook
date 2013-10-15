# -*- coding: utf-8 -*-
class UserAttr < ActiveRecord::Base
  attr_accessible :key, :value
  validates_presence_of  :key, :value

  belongs_to :user
end