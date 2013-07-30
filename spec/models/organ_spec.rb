# -*- coding: utf-8 -*-
require 'spec_helper'

describe Organ do
  before :each do
    # 企业组织
    @zhiyi = create :zhiyi
    @software = create :software, parent: @zhiyi
    @system_organ = create :system_organ

    # 角色
    @zhiyi_admin = create :zhiyi_admin, organ_id: @zhiyi.id
    @zhiyi_member = create :zhiyi_member, organ_id: @zhiyi.id

    # 用户
    @organ_admin = create(:organ_admin)

    # Actor
    @zhiyi_admin_actor = Actor.create(organ_id: @zhiyi.id, membership_id: @zhiyi_admin.id)
    @zhiyi_member_actor = Actor.create(organ_id: @zhiyi.id, membership_id: @zhiyi_member.id)
   
    [@zhiyi_admin_actor, @zhiyi_member_actor].map { |e| e.users << @organ_admin }
  end

  it '应该获得所有通过审核的顶级组织' do
    expect( Organ.available_organs ).to be_empty

    @zhiyi.pass
    expect( Organ.available_organs ).to eq [@zhiyi]
  end

  it '应该获取到组织的所有成员' do
    expect( @zhiyi.members ).to match_array [@organ_admin] 
  end

  it '应该获取组织的所有子级成员' do 
    expect( @zhiyi.children_members ).to be_empty
  end

  it '应该获取到组织的所有成员和后代成员' do
    expect( @zhiyi.members_and_descendants.size ).to eq 1
  end

  it 'system_organ 应该返回系统管理组记录' do
    expect( Organ.system_organ ).to eq @system_organ
  end
end
