# -*- coding: utf-8 -*-
class OrganAttr < ActiveRecord::Base
  attr_accessible :name, :value

  validates :name, :value, presence: true, :uniqueness => true

  belongs_to :organ
end
