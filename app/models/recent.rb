# -*- coding: utf-8 -*-
class Recent < ActiveRecord::Base
  attr_accessible :user_id, :search_id

  validates_presence_of :user_id, :search_id
  validates_uniqueness_of :search_id, :scope => :user_id

  def self.users user
    where(:user_id => user).map{|x| User.find(x.search_id)}
  end
end