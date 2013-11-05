# -*- coding: utf-8 -*-
class Job < ActiveRecord::Base
  include Concerns::Pinyin
  
  attr_accessible :name, :sort

  has_and_belongs_to_many :members

  validates_presence_of :name, :sort
  validates :sort, :numericality => { :only_integer => true, :greater_than => 0, :less_than => 101 }

  before_destroy { members.blank? }
end
