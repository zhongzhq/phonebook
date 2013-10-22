# -*- coding: utf-8 -*-
class Member < ActiveRecord::Base
  attr_accessible :organ_id, :user_id

  belongs_to :user
  belongs_to :organ
  has_and_belongs_to_many :jobs
  has_and_belongs_to_many :addresses
end
