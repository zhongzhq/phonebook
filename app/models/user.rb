# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  include Concerns::Authentication

  attr_accessible :account, :name, :phone

  has_many :members

  validates_presence_of :account, :name, :phone
end
