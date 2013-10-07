# -*- coding: utf-8 -*-
class ActorUser < ActiveRecord::Base
  attr_accessible :actor_id, :user_id

  validates_presence_of :actor_id, :user_id
  validates_uniqueness_of :user_id, :scope => :actor_id

  belongs_to :actor
  belongs_to :user
end