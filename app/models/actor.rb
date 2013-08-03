# -*- coding: utf-8 -*-
class Actor < ActiveRecord::Base
  attr_accessible :membership_id, :organ_id

  validates :membership_id, :organ_id, :presence => true, :existence => true
  validates :membership_id, :uniqueness => { :scope => :organ_id }

  belongs_to :organ
  belongs_to :membership
  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions
  # discard
  has_many :applies

  scope :find_by_organ, -> organ { where organ_id: organ }

  class << self
    def find_by_organ_and_membership organ, membership
      where( organ_id: organ, membership_id: membership ).first
    end
    
    # discard
    # 查找或者新建由 organ 和 membership 组成的 actor 记录
    def find_or_create organ, membership
      find_by_organ_and_membership( organ, membership ).first_or_create
    end
  end
end
