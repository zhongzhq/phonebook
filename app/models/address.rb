# -*- coding: utf-8 -*-
class Address < ActiveRecord::Base
  include Concerns::Pinyin
  
  attr_accessible :name, :phone

  has_and_belongs_to_many :members

  validates :name, :presence => true

  def to_s
    "地址：" + name + " —— " + "电话：" + phone
  end
end
