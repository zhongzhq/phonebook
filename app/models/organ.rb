# -*- coding: utf-8 -*-
class Organ < ActiveRecord::Base
  attr_accessible :name, :parent_id, :description

  validates :name, :presence => true

  has_many :actors
  has_many :memberships
  has_ancestry

  # 系统管理组信息不能修改
  before_update { false if id == Organ.system_organ.try(:id);}
  # 顶级组织在创建后自动初始化组织基本角色
  after_save {Membership.initinlize_memberships_by_organ self unless parent}
  # 子级组织在保存后自动通过
  after_save {pass if parent}

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

  # 组织及后代组织的成员
  def members_and_descendants
    User.find_by_organ(subtree)
  end

  # 添加指定用户到当前组织的指定角色下
  def add user, membership
    # 判断 user 是否加入组织，如果没有加入组织，则添加用户到该组织；
    # 如果加入组织，判断要加入组织和已加入组织是否属于同一根组织，如果是则添加用户到该组织，否则返回 nil
    unless user.organs.blank?
      return unless root == user.root_organ
    end

    actor_users = Actor.find_or_create(self, membership).users
    actor_users << user unless actor_users.include?(user)
  end

  # 申请加入组织的成员
  def apply_members
    Actor.find_or_create(self, Membership.find_or_create( self, Settings.member )).applies.map(&:user)
  end

  class << self
    # 返回顶级组织，且组织审核通过（:state => success）
    def available_organs
      roots.map{|x| x if x.success?}.compact
    end

    # 返回系统管理组顶级的记录
    def system_organ
      where(:name => Settings.system_organ).first
    end
  end

end
