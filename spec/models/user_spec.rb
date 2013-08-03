# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  before :each do
    # 企业组织
    @zhiyi = create :zhiyi
    @software = create :software, parent: @zhiyi

    # 角色
    @zhiyi_admin = create :zhiyi_admin, organ_id: @zhiyi.id
    @zhiyi_member = create :zhiyi_member, organ_id: @zhiyi.id

    # 用户
    @organ_member = create(:organ_member)
    @organ_admin = create(:organ_admin)

    # Actor
    @zhiyi_admin_actor = Actor.create(organ_id: @zhiyi.id, membership_id: @zhiyi_admin.id)
    @zhiyi_member_actor = Actor.create(organ_id: @zhiyi.id, membership_id: @zhiyi_member.id)
   
    [@zhiyi_admin_actor, @zhiyi_member_actor].map { |e| e.users << @organ_admin }
  end

  it '应该可以返回用户指定组织的所有成员' do
    expect( User.find_by_organ(@zhiyi) ).to eq [@organ_admin]
  end

  it '返回用户所属的组织' do
   expect( @organ_admin.organs ).to eq [@zhiyi]
   expect( @organ_member.organs ).to be_empty
 end

  #   it '调整用户组织关系，清除用户以前所属组织，把用户加入 new_organs，并返回新添加的组织' do
  #     expect( @organ_admin.adjust [@zhiyi, @software] ).to eq [@software]
  #     expect( @organ_admin.adjust [@zhiyi] ).to be_empty
  #     expect( @organ_admin.organs ).to eq [@zhiyi]
  #   end
end
