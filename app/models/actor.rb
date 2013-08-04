# -*- coding: utf-8 -*-
class Actor < ActiveRecord::Base
  attr_accessible :membership_id, :organ_id

  validates :membership_id, :organ_id, :presence => true, :existence => true
  validates :membership_id, :uniqueness => { :scope => :organ_id }

  belongs_to :organ
  belongs_to :membership
  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions

  scope :find_by_organ, -> organ { where organ_id: organ }

  class << self
    # 查找指定 organ 和 membership 的 actor 记录
    #   - 找到：直接返回第一条
    #   - 如果未找到：
    #    先判断当前查找的 organ 和 membership 是否属于同一顶级组织
    #    如果属于则自动创建，并返回创建记录；否则返回 nil
    #
    # 调用: Actor.first_or_create :organ => organ, :membership => membership
    def first_or_create args = {}
      result = where(organ_id: args[:organ], membership_id: args[:membership])
      return result.first unless result.blank?
      result.first_or_create if args[:organ].root.id == args[:membership].organ.id
    end
  end
end
