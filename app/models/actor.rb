# -*- coding: utf-8 -*-
class Actor < ActiveRecord::Base
  attr_accessible :membership_id, :organ_id

  validates_presence_of :membership_id, :organ_id
  validates_uniqueness_of :membership_id, :scope => :organ_id

  belongs_to :organ
  belongs_to :membership

  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions

  scope :find_by_organ, -> organ { where organ_id: organ }

  before_destroy {p users.blank? && permissions.blank? }

  def fullname
    return organ.fullname + ":" + membership.name
  end

  class << self
    def first_or_create args = {}
      result = where(organ_id: args[:organ], membership_id: args[:membership])
      return result.first unless result.blank?
      result.first_or_create
    end
  end
end
