# -*- coding: utf-8 -*-

# 定义系统角色
SystemRoles = {
  :organ_member => '组织成员',
  :organ_admin => '组织管理员',
  :system_admin => '系统管理员'
}

# Membership 用户标识 系统用户 角色
# 角色有两种状态：
#   当状态为 0 时，表示：
#     普通角色（如： 经理）
#   当状态为 1 时，表示：
#     系统角色（如：组织成员，组织管理员，系统管理员）
#     系统角色不能被删除，一般通过初始化方式添加

class Membership < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true, uniqueness: true

  has_many :actors

  # 系统角色不能删除
  before_destroy {|membership| membership.status != 1}
  
  class << self

    ## 根据 SystemRoles 的键定义获取系统角色的方法
    #
    # 将会定义如下方法：
    #   Membership.system_admin
    #   Membership.organ_member
    #   Membership.organ_admin
    
    SystemRoles.each do |method_name, membership_name|
      define_method method_name do
        where(name: membership_name).first
      end
    end
  end

  # 初始化系统角色
  SystemRoles.each do |method_name, membership_name|
    unless Membership.send(method_name)
      create!( :name => membership_name).update_attribute(:status, 1)
    end
  end

end
