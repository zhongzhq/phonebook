# -*- coding: utf-8 -*-
class User < ActiveRecord::Base  
  attr_accessible :username, :password, :name, :email, :phone, :password_confirmation, :account
  devise :database_authenticatable, :token_authenticatable, :registerable, :recoverable, :validatable, :timeoutable#, :confirmable

  validates_presence_of :email, :phone
  validates_uniqueness_of :username, :phone
  validates :phone, format: {with: /^\d{11}$/}

  has_and_belongs_to_many :actors
  has_many :applies

  scope :find_by_organ, -> organ { joins(:actors).where(actors: { id: Actor.find_by_organ(organ)} ).uniq }

  # account 是一个虚拟属性，用于页面获取 用户名或邮箱
  attr_accessor :account

  # 判断用户是否为某种角色
  #   - system_admin? 判断用户是否为 系统管理员
  #   - organ_admin? 判断用户是否为 组织管理员
  #   - organ_member? 判断用户是否为 组织成员

  Settings.system_roles.each do |method_name, v|
    define_method method_name.to_s + '?' do
      actors.map { |e| e.membership }.include? Membership.send(method_name)
    end
  end

  # 返回用户的所有角色
  def memberships
    actors.map(&:membership)
  end

  # 返回用户所属的所有组织，如果用户未加入任何组织，则返回 []
  def organs
    actors.map(&:organ).uniq.compact
  end

  # 允许用户使用 用户名或邮箱 登陆
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if account = conditions.delete(:account)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value OR phone = :value", { :value => account.downcase }]).first
    else
      where(conditions).first
    end
  end

  # 调整用户组织关系，清除用户以前所属组织，把用户加入 new_organs，并返回新添加的组织
  def adjust new_organs
    (organs - new_organs).each do |organ|
      actors.delete( Actor.find_or_create( organ, Membership.organ_member ) )
    end
    (new_organs - organs).each do |organ|
      actors << Actor.find_or_create( organ, Membership.organ_member )
    end
  end
end
