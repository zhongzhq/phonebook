# -*- coding: utf-8 -*-
class Membership < ActiveRecord::Base
  attr_accessible :name, :organ_id

  validates :name, :presence => true, :uniqueness => { :scope => :organ_id }
  validates :organ_id, :presence => true, :existence => true

  belongs_to :organ
  has_many :actors

  # 根据当前赋值的 organ_id 找到 organ 的 root；并把 root.id 作为当前 Membership 的 organ_id
  before_validation { self.organ_id = Organ.find(self.organ_id).root.id; true }
  # 每个组织的初始化角色不能修改
  before_update :not_reserved_membership?

  scope :find_all_by_organ, -> organ { where(:organ_id => organ.root.id) }

  class << self
    # discard
    def find_or_create organ, name
      where(organ_id: organ.root.id, name: name).first_or_create
    end

    def organ_member organ
      find_all_by_organ(organ).where(:name => Settings.member).first
    end

    def organ_admin organ
      find_all_by_organ(organ).where(:name => Settings.admin).first
    end

    def initinlize_memberships_by_organ organ
      create :name => Settings.member, :organ_id => organ.root.id
      create :name => Settings.admin, :organ_id => organ.root.id
    end   
  end

  private
  # 判断角色是否不是组织初始化的角色，如果不是则返回 true，否则返回 false
  def not_reserved_membership?
    ![
      Membership.organ_member( Organ.find(organ_id) ).id,
      Membership.organ_admin( Organ.find(organ_id) ).id
    ].include?( self.id )
  end
end