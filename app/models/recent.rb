# -*- coding: utf-8 -*-
class Recent < ActiveRecord::Base
  attr_accessible :recently_id, :user_id

  def self.users user
    User.find(where(:user_id => user).map(&:recently_id))
  end
end
