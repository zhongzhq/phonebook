# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  attr_accessible :name, :parent_id, :state

  validates :name, :presence => true
  # 同一父级的组织名不能重复
  validates_uniqueness_of :name, :scope => :ancestry

  has_ancestry
  has_many :actors

  def members
    User.find_by_organ(self)
  end

  def fullname
    return name unless parent
    parent.fullname + "/" + name
  end
end
