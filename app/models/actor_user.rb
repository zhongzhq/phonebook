# -*- coding: utf-8 -*-
class ActorUser < ActiveRecord::Base
  attr_accessible :user, :actor

  belongs_to :user
  belongs_to :actor

  validates :user_id, uniqueness: { scope: :actor_id, message: '已加入企业'}
end