# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  include Concerns::Pinyin
  
  attr_accessible :name, :comment, :sort, :parent_id, :address, :phone

  has_many :members
  has_ancestry

  validates :name, :presence => true, :uniqueness => true

  before_destroy { children.blank? && members.blank? }

  def fullname
    return name unless parent
    parent.fullname + "/" + name
  end

  default_scope order('sort DESC')
  def self.search value
    return [] if value.blank?
    value = value.downcase.split('').join("%").insert(0, "%").insert(-1, "%")
    where{ (name.like value) | (pinyin.like value) }
  end

  def users
    organ_id = self.id
    User.joins{members.organ}.where{members.organ.id == organ_id}
  end
end
