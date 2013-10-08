# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  attr_accessible :name, :parent_id, :state, :organ_attrs_attributes

  validates :name, :presence => true
  # 同一父级的组织名不能重复
  validates_uniqueness_of :name, :scope => :ancestry

  has_ancestry
  has_many :actors
  has_many :organ_attrs, :dependent => :destroy
  accepts_nested_attributes_for :organ_attrs, :allow_destroy => true, :reject_if =>:all_blank

  def members
    User.find_by_organ(self)
  end

  def fullname
    return name unless parent
    parent.fullname + "/" + name
  end
end
