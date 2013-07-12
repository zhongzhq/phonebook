# -*- coding: utf-8 -*-
class Membership < ActiveRecord::Base
  attr_accessible :name,:status

  validates_presence_of :name

  has_many :actors

  def self.system_admin
    where( name: '系统管理员' ).first
  end

  def self.organ_admin
    where( name: '管理员' ).first
  end

  def self.organ_member
    where( name: '成员' ).first
  end
end
