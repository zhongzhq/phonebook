# -*- coding: utf-8 -*-
class Membership < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true

  has_many :actors

  before_update :not_system_membership?
  before_destroy { not_system_membership? && actors.blank? }

  def not_system_membership?
    not Settings.memberships.include?(self.name)
  end
end
