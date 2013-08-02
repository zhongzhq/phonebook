# -*- coding: utf-8 -*-
class Membership < ActiveRecord::Base
  attr_accessible :name, :organ_id

  validates :name, :organ_id, presence: true
  validates_existence_of :organ_id
  #validates :name, :uniqueness => { :scope => :organ_id }

  belongs_to :organ
  has_many :actors

  before_save :assign_organ_id

  def self.find_or_create organ, name
    where(organ_id: organ.root.id, name: name).first_or_create
  end

  private
  # 根据赋值的 organ_id 找到 organ 的 root；并把 root.id 作为当前 Membership 的 organ_id
  def assign_organ_id
    self.organ_id = Organ.find(organ_id).root.id
  end
end