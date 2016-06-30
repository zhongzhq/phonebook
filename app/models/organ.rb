# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  include Concerns::Pinyin

  attr_accessible :name, :is_leader, :comment, :sort, :parent_id, :address, :phone

  has_many :members
  has_ancestry

  validates :name, :presence => true, :uniqueness => {:scope => :ancestry}

  before_destroy { children.blank? && members.blank? }

  def fullname
    return name unless parent
    parent.fullname + "/" + name
  end

  default_scope order('sort DESC')

  def self.search_by_fullname value
    values = value.split("/")
    organ = Organ.where { name.like values.first }.first

    values.drop(1).each do |x|
      organ = organ.children.where { name.like x }.first
    end
    organ
  end

  def users
    organ_id = self.id
    User.joins { members.organ }.where { members.organ.id == organ_id }
  end
end
