# -*- coding: utf-8 -*-
class Setting < ActiveRecord::Base
  attr_accessible :key, :value
  validates_presence_of :key, :value
  validates_uniqueness_of :key

  def self.[] key
    where(:key => key).first.try(:value)
  end
end
