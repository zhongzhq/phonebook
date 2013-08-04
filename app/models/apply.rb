# -*- coding: utf-8 -*-
# 临时存放用户申请加入某个组织记录的状态，如果用户申请成功，则从表中删除记录

class Apply < ActiveRecord::Base
  attr_accessible :user_id, :actor_id

  validates :user_id, :actor_id, presence: true, existence: true
  validates_uniqueness_of :user_id, scope: :actor_id

  belongs_to :actor
  belongs_to :user

  # 当审核通过，状态为 success 时，自动写入记录到 actors_users 中，并从 applies 中删除记录
  after_save { (actor.users << user; destroy) if success? }

  state_machine :initial => :apply do
    event :pass do
      transition :apply => :success
    end

    event :not_pass do
      transition :apply => :failure
    end
  end

  # 添加临时申请记录，并检验数据合法性
  #
  # 调用: Apply.safe_add :user => user, :organ => organ
  def self.safe_add args = {}
    # 判断用户当前申请组织和正在审核中的组织是否属于同一顶级组织
    where(:user_id => args[:user].id).first.try(:actor_id).tap do |actor_id|
      unless actor_id.blank?
        return unless Actor.find(actor_id).organ.root == args[:organ].try(:root)
      end
    end

    # 判断用户是否加入组织；如果已加入组织，判断当前加入组织和已加入组织是否属于同一顶级组织
    unless args[:user].organs.blank?
      return unless args[:organ].try(:root) == args[:user].organs.first.root
    end

    # 判断用户是否已加入企业
    actor = Actor.first_or_create(
      :organ => args[:organ], :membership => Membership.organ_member(args[:organ]) )
    unless actor.users.include? args[:user]
      new(:user_id => args[:user].id, :actor_id => actor.id ).save
    end
  end

  # 返回指定组织的申请记录
  def self.members organ
    Apply.where(:actor_id => Actor.find_by_organ(organ).map(&:id))
  end
end