# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  attr_accessor :account

  attr_accessible :name, :username, :cellphone, :password, :password_confirmation, :state, :account  
  validates_presence_of :username, :password, :cellphone, :on => :create
  
  has_many :actor_users
  has_many :actors, :through => :actor_users

  has_secure_password

  scope :find_by_organ, -> organ { joins(:actors).where(actors: { id: Actor.find_by_organ(organ)} ).uniq }

  def find_memberships_by_organ organ_id
    actors.where(:organ_id => organ_id).map(&:membership).map(&:name).join("/")
  end

  # 通过用户名或手机号查找用户
  def self.find_first_by_account account
    where(["lower(username) = :value OR cellphone = :value", { :value => account.downcase }]).first
  end
end
