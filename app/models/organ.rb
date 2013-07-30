# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  attr_accessible :name, :parent_id, :address, :postalcode, :areacode, :description

  validates :name, presence: true

  has_many :actors
  has_ancestry

  state_machine :initial => :apply do
    event :pass do
      transition :apply => :success
    end

    event :not_pass do
      transition :apply => :failure
    end
  end

  # 组织的所有成员
  def members
    User.find_by_organ(self)
  end

  # 组织的所有子级成员
  def children_members
    User.find_by_organ(children)
  end

  # 组织及后代组织的成员
  def members_and_descendants
    User.find_by_organ(subtree)
  end

  # 申请加入组织的成员
  # def apply_members
  #   Actor.find_or_create(self, Membership.organ_member).applies.map(&:user)
  # end

  class << self
    # 返回顶级组织，且组织审核通过（state: success）
    def available_organs
      roots.map{|x| x if x.success?}.compact
    end

    # 返回系统管理组记录
    def system_organ
      where(name: Settings.system_organ).first
    end
  end
end
