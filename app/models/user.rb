# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  include Concerns::Authentication
  include Concerns::Pinyin
  attr_accessor :organ

  serialize :properties, ActiveRecord::Coders::Hstore
  
  attr_accessible :account, :name, :phone, :comment, :properties, :organ

  has_many :members

  validates_presence_of :account, :name, :phone
  validates_presence_of :password, :on => :create
  # validate :exist_jobs

  before_destroy { members.blank? }

  attr_accessor :jobs
  attr_accessible :jobs

  def exist_jobs
    errors.add(:jobs, :blank) if jobs.delete_if{|x| x.blank?}.blank?
  end

end
