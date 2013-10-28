# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  include Concerns::Authentication
  include Concerns::Pinyin

  serialize :properties, ActiveRecord::Coders::Hstore
  
  attr_accessible :account, :name, :phone, :comment

  has_many :members

  validates_presence_of :account, :name, :phone
  validates_presence_of :password, :on => :create
  # validate :exist_jobs

  attr_accessor :jobs, :addresses
  attr_accessible :jobs, :addresses

  def exist_jobs
    errors.add(:jobs, :blank) if jobs.delete_if{|x| x.blank?}.blank?
  end
end
