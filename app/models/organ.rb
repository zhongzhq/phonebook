# -*- coding: utf-8 -*-

class Organ < ActiveRecord::Base
  attr_accessible :name, :rank_id, :parent_id, :address, :postalcode, :areacode, :description

  validates_presence_of :name, :rank_id
  validates_existence_of :rank_id

  belongs_to :rank
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
        # 判断 user 是否加入组织，如果没有加入组织，则添加用户到该组织；
        # 如果加入组织，判断要加入组织和已加入组织是否属于同一根组织，如果是则添加用户到该组织，否则返回 nil
        unless user.organs.blank?
          return unless root == user.organs.first.root
        end

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
