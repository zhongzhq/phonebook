# -*- coding: utf-8 -*-
class Job < ActiveRecord::Base
  include Concerns::Pinyin
  
  attr_accessible :name, :sort

  has_and_belongs_to_many :members
end
