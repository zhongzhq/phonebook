# -*- coding: utf-8 -*-
class Membership < ActiveRecord::Base
  attr_accessible :name, :organ_id

  validates :name, :presence => true, :uniqueness => { :scope => :organ_id }
  validates :organ_id, :presence => true, :existence => true

  belongs_to :organ
  has_many :actors

  # 根据 organ_id 找到 root；并把 root.id 作为当前 Membership记录 的 organ_id
  before_validation { self.organ_id = Organ.find(self.organ_id).root.id; true }
  scope :find_by_organ, -> organ { where(:organ_id => organ.root.id) }

end
