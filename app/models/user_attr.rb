# -*- coding: utf-8 -*-
class UserAttr < ActiveRecord::Base
  attr_accessible :key, :value, :user_id
  validates_presence_of  :key, :value, :user_id

  belongs_to :user
end