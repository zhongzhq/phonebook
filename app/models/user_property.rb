# -*- coding: utf-8 -*-
class UserProperty < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true

  before_create :name_to_pinyin_as_key

  private
  def name_to_pinyin_as_key
    self.key = HanziToPinyin.hanzi_2_py(self.name).gsub(/[;|,]/, '')
  end
end
