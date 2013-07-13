# -*- coding: utf-8 -*-
class Actor < ActiveRecord::Base
  attr_accessible :membership_id, :organ_id

  belongs_to :organ
  belongs_to :membership

  has_many :actor_users
  has_many :users, :through => :actor_users

  scope :find_by_organ_and_membership, ->(organ, membership) { where(organ_id: organ.id).where(membership_id: membership.id)}

  class << self
    # 查找或者新建由 组织管理员 和 新的组织 组成 Actor
    def find_or_new_organ_admin organ
      find_or_new_actor(organ, Membership.system_admin)
    end

    # 查找或者新建由 组织成员 和 新的组织 组成 Actor
    def find_or_new_organ_member organ
      find_or_new_actor(organ, Membership.organ_member)
    end

    private
    def find_or_new_actor new_organ, membership
      result = find_by_organ_and_membership( new_organ, membership)
      result.empty? ? create(organ_id: new_organ.id, membership_id: membership.id) : result.first
    end
  end
end
