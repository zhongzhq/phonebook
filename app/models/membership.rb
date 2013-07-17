# -*- coding: utf-8 -*-
class Membership < ActiveRecord::Base
  attr_accessible :name, :status

  validates :name, presence: true, uniqueness: true

  has_many :actors

  # 初始化系统角色
  I18n.t("phonebook.membership").each { |k, v| create(name: v) }

  # 定义获取系统角色的方法
  #
  # 如果在 zh_CN.yml 中定义如下：
  # zh_CN:
  #   phonebook:
  #     membership:
  #       system_admin: 系统管理员
  # 
  # 那么，就可以调用方法： Membership.system_admin
  
  class << self
    I18n.t("phonebook.membership").each do |k, v|
      define_method k do
        where(name: I18n.t("phonebook.membership.#{k.to_s}")).first
      end
    end
  end

end
