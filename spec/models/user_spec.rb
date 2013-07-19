# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
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
    @guest = create(:guest)
    @organ_member = create(:organ_member)
    @organ_admin = create(:organ_admin)
    @system_admin = create(:system_admin)

    # Actor
    @zhiyi_admin_actor = Actor.create(organ_id: @zhiyi.id, membership_id: Membership.organ_admin.id)
    @zhiyi_member_actor = Actor.create(organ_id: @zhiyi.id, membership_id: Membership.organ_member.id)
    @system_admin_actor = Actor.create(membership_id: Membership.system_admin.id)

    [@zhiyi_admin_actor, @zhiyi_member_actor].map { |e| e.users << @organ_admin }
    @system_admin_actor.users << @system_admin
  end

  it '如果用户验证邮箱后，返回 true；如果用户未验证邮箱，返回 nil 或 false' do
    expect( @organ_admin.confirm? ).to be_nil

    # 激活用户邮箱
    @organ_admin.update_attribute(:confirmed_at, Time.now)
    @organ_admin.update_attribute(:confirmation_token, nil)

    expect( @organ_admin.confirm? ).to be_true
  end

  it '如果用户是系统管理员，则返回 true，否则返回 false' do
    expect( @system_admin.system_admin? ).to be_true
    expect( @organ_admin.system_admin? ).to be_false
  end

  it '返回用户的所有角色' do
    expect( @organ_admin.memberships ).to eq [Membership.organ_admin, Membership.organ_member]
    expect( @system_admin.memberships ).to eq [Membership.system_admin]
  end

  it '返回用户所属的组织' do
    expect( @organ_admin.organ ).to eq [@zhiyi]
    expect( @system_admin.organ ).to be_empty
  end
end