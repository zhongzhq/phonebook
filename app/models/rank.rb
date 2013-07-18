# -*- coding: utf-8 -*-

# Rank 用于标识组织的等级

class Rank < ActiveRecord::Base
  attr_accessible :name, :parent_id

  validates :name, presence: true, uniqueness: true

  has_many :organs
  has_ancestry
end
