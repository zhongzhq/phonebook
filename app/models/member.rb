# -*- coding: utf-8 -*-
class Member < ActiveRecord::Base
  attr_accessible :organ_id, :user_id

  belongs_to :user
  belongs_to :organ
  has_and_belongs_to_many :jobs

  def set_jobs job_ids
    jobs.clear
    Job.find(job_ids.delete_if{|x| x.blank?}).map { |e| jobs << e }
  end

  def self.first_or_create args = {}
    where(:user_id => args[:user_id], :organ_id => args[:organ_id]).first_or_create
  end
end
