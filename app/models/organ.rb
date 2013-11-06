# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  include Concerns::Pinyin
  
  attr_accessible :name, :description, :sort, :parent_id, :address, :phone

  has_many :members
  has_ancestry

  validates :name, :presence => true, :uniqueness => true

  before_destroy { children.blank? && members.blank? }

  def fullname
    return name unless parent
    parent.fullname + "/" + name
  end

  scope :desc, -> { order("sort DESC") }
end
