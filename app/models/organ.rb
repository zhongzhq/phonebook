# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  attr_accessible :name, :parent_id, :description

  validates :name, :presence => true
  # 同一父级的组织名不能重复
  validate { errors.add(:name, :taken) if siblings.reject{|x| x if x.id == self.id}.map(&:name).include?(self.name) }

  has_many :actors
  has_many :memberships
  has_ancestry

  state_machine :initial => :enabled do
    event :open do
      transition :disable => :enabled
    end

    event :close do
      transition :enabled => :disable
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

end
