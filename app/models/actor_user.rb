# -*- coding: utf-8 -*-
class ActorUser < ActiveRecord::Base
  attr_accessible :user_id, :actor_id

  belongs_to :user
  belongs_to :actor
end