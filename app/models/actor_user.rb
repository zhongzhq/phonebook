# -*- coding: utf-8 -*-
class ActorUser < ActiveRecord::Base
  attr_accessible :user, :actor

  belongs_to :user
  belongs_to :actor
end