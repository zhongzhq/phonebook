# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :password, :name, :email, :phone, :password_confirmation, :account
  devise :database_authenticatable, :token_authenticatable, :registerable, :recoverable, :validatable, :timeoutable#, :confirmable

  validates_presence_of :email, :phone
  validates :phone, :uniqueness => true, format: {with: /^\d{11}$/}

  has_and_belongs_to_many :actors

  scope :find_by_organ, -> organ { joins(:actors).where(actors: { id: Actor.find_by_organ(organ)} ).uniq }

  # account 是一个虚拟属性，用于页面获取 用户名、邮箱或手机号
  attr_accessor :account

  # 返回用户所属的所有组织，如果用户未加入任何组织，则返回 []
  def organs
    Organ.joins(:actors).where(:actors => {:id => actors}).uniq
  end

  def permissions
    actors.map(&:permissions).flatten.uniq
  end

  # 调整用户某个组织下的角色
  def adjust organ, new_actors
    old_actors = actors.where(:organ_id => organ)
    (old_actors - new_actors).each { |actor| actors.delete actor }
    (new_actors - old_actors).each { |actor| actors << actor }
  end

  # 允许用户使用 手机号或邮箱 登陆
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if account = conditions.delete(:account)
      where(conditions).where(["lower(email) = :value OR phone = :value", { :value => account.downcase }]).first
    else
      where(conditions).first
    end
  end
end
