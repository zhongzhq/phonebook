# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  attr_accessible :description, :name, :sort, :parent_id

  has_many :members
  has_ancestry

  validates_presence_of :name, :sort
  validates_uniqueness_of :name, :scope => :ancestry

  before_destroy { children.blank? && members.blank? }

  def fullname
    return name unless parent
    parent.fullname + "/" + name
  end
end
