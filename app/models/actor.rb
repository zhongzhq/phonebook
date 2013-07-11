# -*- coding: utf-8 -*-
class Actor < ActiveRecord::Base
  attr_accessible :membership_id, :organ_id

  belongs_to :organ
  belongs_to :membership

  has_many :actor_users
  has_many :users, :through => :actor_users
end