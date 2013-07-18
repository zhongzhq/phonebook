# -*- coding: utf-8 -*-
class Rank < ActiveRecord::Base
  attr_accessible :name, :parent_id

  validates :name, presence: true, uniqueness: true

  has_many :organs
  has_ancestry

  # rank 只能有一个 children
  before_save {|rank| p rank; rank.parent.try(:children).blank? }
end
