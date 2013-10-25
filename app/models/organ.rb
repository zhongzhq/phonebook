# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  include Concerns::Pinyin
  
  attr_accessible :description, :name, :sort, :parent_id, :is_index

  has_many :members
  has_ancestry

  validates_presence_of :name, :sort
  validates_uniqueness_of :name, :scope => :ancestry
  validates :sort, :numericality => { :only_integer => true, :greater_than => 0, :less_than => 101 }

  def fullname
    return name unless parent
    parent.fullname + "/" + name
  end

  # 首页显示的组织, is_index 值为 1 时，表示显示该组织
  def self.index_organ
    where(:is_index => 1)
  end
end
