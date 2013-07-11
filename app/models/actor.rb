# -*- coding: utf-8 -*-
class Actor < ActiveRecord::Base
  attr_accessible :membership_id, :organ_id

  belongs_to :organ
  belongs_to :membership
  has_and_belongs_to_many :users
end