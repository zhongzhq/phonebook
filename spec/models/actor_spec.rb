# -*- coding: utf-8 -*-
require 'spec_helper'

describe Actor do
  before :each do
    # 角色
    Settings.system_roles.each { |key, value| Membership.create!( :name => value ).update_attribute(:status, 1) }

    # 等级
    @qi_ye = create(:qi_ye)
    @bu_men = create :bu_men, parent: @qi_ye

    # 部门
    @zhiyi = create :zhiyi, rank: @qi_ye
    @software = create :software, rank: @bu_men, parent: @zhiyi

    # 用户
    @organ_admin = create(:organ_admin)

    # Actor
    @zhiyi_admin_actor = Actor.create(organ_id: @zhiyi.id, membership_id: Membership.organ_admin.id)
    @zhiyi_member_actor = Actor.create(organ_id: @zhiyi.id, membership_id: Membership.organ_member.id)

    [@zhiyi_admin_actor, @zhiyi_member_actor].map { |e| e.users << @organ_admin }
  end

  it '通过指定的 组织和角色 查找 actor 记录' do
    actor = Actor.find_by_organ_and_membership( @zhiyi, Membership.organ_admin ).first
    expect( actor.organ ).to eq @zhiyi
    expect( actor.membership ).to eq Membership.organ_admin
  end

  it '应该查到指定组织的所有 actor' do
    expect( Actor.find_by_organ @zhiyi ).to eq [@zhiyi_admin_actor, @zhiyi_member_actor]
  end

  context '调用 find_or_create 方法' do
    it '如果 actor 已经存在，应该返回对应 actor 记录' do
      actor = Actor.find_or_create @zhiyi, Membership.organ_admin
      expect( actor.organ ).to eq @zhiyi
      expect( actor.membership ).to eq Membership.organ_admin
    end

    it '如果 actor 不存在，应该创建并返回对应 actor 记录' do
      expect( Actor.find_by_organ_and_membership(@software, Membership.organ_member) ).to be_empty
      
      actor = Actor.find_or_create @software, Membership.organ_member
      expect( actor.organ ).to eq @software
      expect( actor.membership ).to eq Membership.organ_member
    end
  end
end
