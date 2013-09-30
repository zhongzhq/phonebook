# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :username, :phone, :name, :password, :account
  devise :database_authenticatable, :token_authenticatable, :timeoutable

  validates_presence_of :username, :phone
  validates :username, :phone, :uniqueness => true
  validates :phone, format: {with: /^\d{11}$/}

  has_and_belongs_to_many :actors

  state_machine :initial => :enabled do
    event :start do
      transition :disabled => :enabled
    end

    event :close do
      transition :enabled => :disabled
    end
  end

  scope :find_by_organ, -> organ { joins(:actors).where(actors: { id: Actor.find_by_organ(organ)} ).uniq }

  # 返回用户所属的所有组织，如果用户未加入任何组织，则返回 []
  def organs
    Organ.joins(:actors).where(:actors => {:id => actors}).uniq
  end

  def root_organs
    organs.map(&:root).uniq
  end

  # 调整用户某个组织下的角色
  def adjust organ, new_actors
    old_actors = actors.where(:organ_id => organ)
    (old_actors - new_actors).each { |actor| actors.delete actor }
    (new_actors - old_actors).each { |actor| actors << actor }
  end

  # account 是一个虚拟属性，用于页面获取用户名或手机号; 允许用户使用用户名或手机号登陆
  attr_accessor :account
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if account = conditions.delete(:account)
      where(conditions).where(["lower(username) = :value OR phone = :value", { :value => account.downcase }]).first
    else
      where(conditions).first
    end
  end
end
