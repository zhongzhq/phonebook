# -*- coding: utf-8 -*-

# Organ 用户记录组织的详细信息（姓名，等级，上级组织，组织地址，邮编，区号，状态，描述）
#  - 组织必须存在一个等级
#  - 组织的状态有两种：禁用（status = 0）, 启用（status = 1）

class Organ < ActiveRecord::Base
  attr_accessible :name, :rank_id, :parent_id, :address, :postalcode, :areacode, :status, :description

  validates_presence_of :name, :rank_id
  validates_existence_of :rank_id

  belongs_to :rank
  has_many :actors
  has_ancestry

  ## 根据 Settings.system_roles 的 键 来定义给组织添加 不同角色用户 的方法
  # 
  # 将会定义如下方法, 方法接受一个 user 参数：
  #   add_member(user): 向组织中添加成员
  #   add_admin(user): 向组织中添加管理员
  # 
  # 如果添加成功，返回当前组织下此角色的所有成员。如果成员已存在于该组织对应角色下，那么添加失败，返回 nil

  Settings.system_roles.each do |method_name, v|
    if method_name.to_s.include? 'organ_'
      define_method method_name.to_s.sub(/organ/, 'add') do |user|
        actor_users = Actor.find_or_create(self, Membership.send(method_name)).users
        actor_users << user unless actor_users.include?(user)
      end
    end
  end

  # 组织的所有成员
  def members
    actors.map(&:users).flatten.uniq
  end

  # 组织的所有子级成员
  def children_members
    children.map(&:members).flatten
  end
end
