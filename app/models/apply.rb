# -*- coding: utf-8 -*-
#
# 临时存放用户申请加入某个组织记录的状态，如果用户申请成功，则从表中删除记录

class Apply < ActiveRecord::Base
  attr_accessible :user_id, :actor_id

  validates :user_id, :actor_id, presence: true, existence: true
  validates_uniqueness_of :user_id, scope: :actor_id

  belongs_to :actor
  belongs_to :user

  after_save { (actor.users << user; destroy) if success? }

  state_machine :initial => :apply do
    event :pass do
      transition :apply => :success
    end

    event :not_pass do
      transition :apply => :failure
    end
  end

  def self.find_by_user_and_organ user, organ
    find(:first, conditions: {user_id: user.id, actor_id: Actor.find_or_create(organ, Membership.organ_member).id})
  end

  # 把用户加入组织的成员中
  def self.add user, organ
    unless user.organs.blank?
      return unless organ.try(:root) == user.organs.first.root
    end

    # 找到组织和组织成员组合的 actor 记录
    organ_member_actor = Actor.find_or_create(organ, Membership.organ_member)
    unless organ_member_actor.users.include? user
      new(user_id: user.id, actor_id: organ_member_actor.id).save
    end
  end
end