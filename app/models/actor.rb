# -*- coding: utf-8 -*-

# Actor 由 Membership（角色）和 Organ（组织）共同组成一条记录
# 用于把 系统用户 和 组织，角色 联系起来，标识 某个组织 下的 某种角色
# Actor 不能存在两条 membership_id 和 organ_id 同时相同的记录

class Actor < ActiveRecord::Base
  attr_accessible :membership_id, :organ_id

  validates_presence_of :membership_id
  validates_existence_of :membership_id, :organ_id, :allow_nil => true
  validates_uniqueness_of :membership_id, scope: :organ_id

  belongs_to :organ
  belongs_to :membership
  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions
  has_many :applies

  scope :find_by_organ_and_membership, -> organ, membership { where organ_id: organ, membership_id: membership }
  scope :find_by_organ, -> organ { where organ_id: organ }
end
