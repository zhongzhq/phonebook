# -*- coding: utf-8 -*-
class Membership < ActiveRecord::Base
  attr_accessible :name, :organ_id

  validates :name, presence: true, :uniqueness => true
  validates :organ_id, presence: true

  belongs_to :organ
  has_many :actors

  # 角色自动关联根组织
  before_save {self.organ_id = Organ.find(:first, :conditions => {:id => organ_id}).root.id}
end
