# -*- coding: utf-8 -*-
class Membership < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name
  validates_uniqueness_of :name


  has_many :actors

end
