# -*- coding: utf-8 -*-

# Rank model 用于标识 组织 的等级
# Rank 的 每条记录 对应 零条或一条 子记录
class Rank < ActiveRecord::Base
  attr_accessible :name, :parent_id

  validates :name, presence: true, uniqueness: true

  has_many :organs
  has_ancestry

  # 一条 rank 记录只能有一个 children 记录
  before_save {|rank| p rank; rank.parent.try(:children).blank? }
end
