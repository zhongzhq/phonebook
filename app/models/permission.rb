# -*- coding: utf-8 -*-
class Permission < ActiveRecord::Base
  # level 默认为 0，表示权限属于系统管理组
  attr_accessible :name, :code, :description, :level

  validates :name, :code, presence: true, :uniqueness => true
  validates :level, :inclusion => { :in => [0, 1] }

  has_and_belongs_to_many :actors
end
