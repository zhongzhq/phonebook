# -*- coding: utf-8 -*-
class UserProperty < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true

  before_create :name_to_pinyin_as_key

  # 属性启用或禁用状态控制
  state_machine :state, :initial => :opened do
    event :close do
      transition :opened => :closed
    end

    event :start do
      transition :closed => :opened
    end
  end

  def self.enabled_properties
    where(:state => "opened")
  end

  private
  def name_to_pinyin_as_key
    self.key = HanziToPinyin.hanzi_2_py(self.name).gsub(/[;|,]/, '')
  end
end
