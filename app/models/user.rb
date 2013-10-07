# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  attr_accessor :account, :membership_ids

  attr_accessible :name, :username, :cellphone, :password, :password_confirmation, :state, :account, :membership_ids
  validates_presence_of :username, :cellphone
  validates_presence_of :password, :on => :create
  
  has_many :actor_users
  has_many :actors, :through => :actor_users

  has_secure_password

  scope :find_by_organ, -> organ { joins(:actors).where(actors: { id: Actor.find_by_organ(organ)} ).uniq }

  def find_memberships_by_organ organ_id
    actors.where(:organ_id => organ_id).map(&:membership).map(&:name).join("/")
  end

  def add_actor memberships, organ
    actors = (memberships || []).map do |membership|
      Actor.first_or_create :organ => organ, :membership => Membership.find(membership)
    end
    actors.each do |actor|
      ActorUser.create(:actor_id => actor.id, :user_id => self.id)
    end
  end

  # 通过用户名或手机号查找用户
  def self.find_first_by_account account
    where(["lower(username) = :value OR cellphone = :value", { :value => account.downcase }]).first
  end
end
