# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  attr_accessible :name, :parent_id, :description

  validates :name, :presence => true
  # 同一父级的组织名不能重复
  validates_uniqueness_of :name, :scope => :ancestry

  has_many :actors
  has_many :memberships
  has_ancestry

  state_machine :initial => :enabled do
    event :start do
      transition :disabled => :enabled
    end

    event :close do
      transition :enabled => :disabled
    end
  end

  def members
    User.find_by_organ(self)
  end

  def subtree_members
    User.find_by_organ(subtree)
  end

  def fullname
    return name unless parent
    parent.fullname + "/" + name
  end

  def self.system_organ
    where(:name => Settings.organ.system).first
  end
end
