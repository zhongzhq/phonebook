# -*- coding: utf-8 -*-
class OrganApply < ActiveRecord::Base
  attr_accessible :user_id, :organ_name, :description

  validates :user_id, :organ_name, presence: true, :uniqueness => true
  validate { errors.add(:organ_name, :taken) unless Organ.where(:name => self.organ_name).blank? }

  after_save :init_organ, :if => :success?

  state_machine :initial => :review do
    event :pass do
      transition [:review, :failure] => :success
    end

    event :refuse do
      transition :review => :failure
    end

    event :apply do
      transition :failure => :review
    end
  end

  private
  def init_organ
    organ = Organ.create :name => self.organ_name
    # 初始化角色
    admin = Membership.create :name => Settings.membership.admin, :organ_id => organ.id
    member = Membership.create :name => Settings.membership.member, :organ_id => organ.id
    # 给用户分配管理员角色
    organ_admin_actor = Actor.first_or_create(:organ => organ, :membership => admin)
    User.find(self.user_id).actors << organ_admin_actor
    # 给用户分配权限
    Permission.where(:code => 'master_organ').first.actors << organ_admin_actor
  end
end
