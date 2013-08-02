# -*- coding: utf-8 -*-
require 'spec_helper'

describe Actor do
  before :each do
    # 企业组织
    @zhiyi = create :zhiyi
    @software = create :software, parent: @zhiyi

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

  it '通过指定的 组织和角色 查找 actor 记录' do
   actor = Actor.find_by_organ_and_membership( @zhiyi, @zhiyi_admin ).first
   expect( actor.organ ).to eq @zhiyi
   expect( actor.membership ).to eq @zhiyi_admin
 end

 it '应该查到指定组织的所有 actor' do
   expect( Actor.find_by_organ @zhiyi ).to eq [@zhiyi_admin_actor, @zhiyi_member_actor]
 end
end
