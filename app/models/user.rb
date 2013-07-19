# -*- coding: utf-8 -*-
class User < ActiveRecord::Base  
  attr_accessible :username, :password, :name, :email, :phone, :password_confirmation, :account
  devise :database_authenticatable, :token_authenticatable, :registerable, :recoverable, :validatable#, :confirmable

  validates_presence_of :username, :password, :email, :phone, :password_confirmation
  validates :phone, format: {with: /^\d{11}$/}

  has_and_belongs_to_many :actors

  # account 是一个虚拟属性，用于页面获取 用户名或邮箱
  attr_accessor :account
  
  # 判断用户邮箱是否激活
  def confirm?
    confirmed_at && confirmation_token.blank?
  end

  # 判断用户是否为系统管理员
  def system_admin?
    actors.map { |e| e.membership }.include? Membership.system_admin
  end

  # 返回用户的所有角色
  def memberships
    actors.map(&:membership)
  end

  # 返回用户所属的所有组织，如果用户未加入任何组织，则返回 []
  def organ
    actors.map(&:organ).uniq.compact
  end

  # 允许用户使用 用户名或邮箱 登陆
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if account = conditions.delete(:account)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => account.downcase }]).first
    else
      where(conditions).first
    end
  end
end
