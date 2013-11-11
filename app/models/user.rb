# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  include Concerns::Authentication
  include Concerns::Pinyin
  attr_accessor :organ

  serialize :properties, ActiveRecord::Coders::Hstore
  
  attr_accessible :account, :name, :mobile_phone, :office_phone, :office_address, :comment, :properties, :organ

  has_many :members

  validates :account, :name, :mobile_phone, :presence => true
  validates_presence_of :password, :on => :create
  # validate :exist_jobs

  before_destroy { members.blank? }

  attr_accessor :jobs
  attr_accessible :jobs

  def exist_jobs
    errors.add(:jobs, :blank) if jobs.delete_if{|x| x.blank?}.blank?
  end

  def update_properties args = {}
    args.each do |key, value|
      properties[key] = value
    end
    save
  end

  def admin_member
    members.each do |member|
      return member if member.admin?
    end
  end

end
