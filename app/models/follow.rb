# -*- coding: utf-8 -*-
class Follow < ActiveRecord::Base
  attr_accessible :follower_id, :followed_id

  validates_presence_of :follower_id, :followed_id
  validates_uniqueness_of :followed_id, :scope => :follower_id

  scope :find_by_follower, -> follower {where(:follower_id => follower)}
  scope :find_by_follower_and_followed, -> follower, followed { find_by_follower(follower).where(:followed_id => followed) }
end