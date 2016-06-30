# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  include Concerns::Authentication
  include Concerns::Pinyin
  attr_accessor :jobs

  serialize :properties, ActiveRecord::Coders::Hstore
  
  attr_accessible :account, :name, :mobile_phone, :office_phone, :office_address, :comment, :properties, :jobs, :sort

  has_many :members

  delegate :hello, :to => :greeter

  validates :account, :name, :mobile_phone, :presence => true
  validates :account, :mobile_phone, :uniqueness => true
  validates_presence_of :password, :on => :create

  before_destroy { members.blank? }

  def update_properties args = {}
    args.each do |key, value|
      properties[key] = value
    end
    save
  end

  def admin_organ
    return Organ.find(1) if super_user?
    members.each do |member|
      return member.organ if member.admin?
    end
    nil
  end

  def super_user?
    members.each do |member|
      return true if member.super_admin?
    end
    false
  end

  def visible_leader
    members.first.try do |member|
      member.present? ? member.is_visible_leader : 0
    end
  end

end
