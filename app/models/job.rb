# -*- coding: utf-8 -*-
class Job < ActiveRecord::Base
  include Concerns::Pinyin
  
  attr_accessible :name, :sort

  has_and_belongs_to_many :members

  validates :name, :presence => true, :uniqueness => true

  before_destroy { members.blank? }

  default_scope order('sort DESC')
end
