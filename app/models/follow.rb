# -*- coding: utf-8 -*-
class Follow < ActiveRecord::Base
  attr_accessible :followed_id, :user_id

  def self.users user
    User.find(where(:user_id => user).map(&:followed_id))
  end

  def self.exist? user_id, followed_id
    where(:user_id => user_id, :followed_id => followed_id).present?
  end
end
