# -*- coding: utf-8 -*-
# 临时存放用户申请加入某个组织记录的状态，如果用户申请成功，则从表中删除记录

class UserApply < ActiveRecord::Base
  attr_accessible :user_id, :actor_id

  validates :user_id, :actor_id, presence: true, existence: true
  validates_uniqueness_of :user_id, scope: :actor_id

  belongs_to :actor
  belongs_to :user

  # 当审核通过，状态为 success 时，自动写入记录到 actors_users 中，并从 applies 中删除记录
  after_save { (actor.users << user; destroy) if success? }

  state_machine :initial => :review do
    event :pass do
      transition :review => :success
    end
  end

  # 添加临时申请记录，并检验数据合法性
  #
  # 调用: Apply.safe_add :user => user, :organ => organ, :membership => membership
  def self.safe_add args = {}
    actor = Actor.first_or_create( :organ => args[:organ], :membership => args[:membership] )

    # 如果不能找到 actor 则添加失败
    return false if actor.nil?

    # 判断用户是否已加入企业    
    unless actor.users.include? args[:user]
      new(:user_id => args[:user].id, :actor_id => actor.id ).save
    end
  end

  # 返回指定组织的申请记录
  def self.members organ
    where(:actor_id => Actor.find_by_organ(organ).map(&:id))
  end
end
