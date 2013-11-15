# -*- coding: utf-8 -*-
class Member < ActiveRecord::Base
  attr_accessible :organ_id, :user_id, :is_admin

  belongs_to :user
  belongs_to :organ
  has_and_belongs_to_many :jobs

  validates :organ_id, :presence => true, :uniqueness => { :scope => :user_id}
  validates :user_id, :presence => true

  def set_jobs job_ids
    jobs.clear
    Job.find(job_ids.delete_if{|x| x.blank?}).map { |e| jobs << e }
  end

  def admin?
    is_admin == 1
  end

  class << self
    def find_by_user_and_organ user_id, organ_id
      where(:user_id => user_id, :organ_id => organ_id).first
    end

    def first_or_create user_id, organ_id
      where(:user_id => user_id, :organ_id => organ_id).first_or_create
    end
  end
end
