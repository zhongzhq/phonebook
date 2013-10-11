# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  attr_accessor :account, :membership_ids, :current_password

  # 头像
  has_attached_file :avatar, :styles => { :original => "256x256>", :thumb => "64x64>" },
  :url => "/uploads/:attachment/:style/:username.:extension",
  :path => "/:rails_root/public/uploads/:attachment/:style/:username.:extension"

  attr_accessible :name, :username, :cellphone, :password, :password_confirmation, :state, :avatar, :account, :membership_ids, :current_password, :user_attrs_attributes
  validates_presence_of :username, :cellphone, :membership_ids
  validates_presence_of :password, :on => :create
  
  has_many :actor_users
  has_many :actors, :through => :actor_users
  has_many :user_attrs, :dependent => :destroy
  accepts_nested_attributes_for :user_attrs, :allow_destroy => true, :reject_if =>:all_blank

  has_secure_password

  before_validation { self.membership_ids.delete_if{|x| x.blank? } }

  scope :find_by_organ, -> organ { joins(:actors).where(actors: { id: Actor.find_by_organ(organ)} ).uniq }

  def find_memberships_by_organ organ_id
    actors.where(:organ_id => organ_id).map(&:membership)
  end

  def add_actor new_ids, organ
    old_ids = find_memberships_by_organ(organ).map(&:id)

    delete_actors = (old_ids - new_ids).map do |mem_id|
      Actor.first_or_create :organ => organ, :membership => Membership.find(mem_id)
    end
    delete_actors.each do |actor|
      ActorUser.where(:actor_id => actor.id, :user_id => self.id).map(&:destroy)
    end

    add_actors = (new_ids - old_ids).map do |mem_id|
      Actor.where(:organ_id => organ, :membership_id => Membership.find(mem_id)).first
    end
    add_actors.each do |actor|
      ActorUser.create(:actor_id => actor.id, :user_id => self.id)
    end    
  end

  # 通过用户名或手机号查找用户
  def self.find_first_by_account account
    where(["lower(username) = :value OR cellphone = :value", { :value => account.downcase }]).first
  end
end
