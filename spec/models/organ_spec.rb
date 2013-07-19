# -*- coding: utf-8 -*-
require 'spec_helper'

describe Organ do
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
    @organ_member = create(:organ_member)
  end

  context '当组织调用 add_member 或者 add_admin 方法时' do
    it '应该添加指定用户到组织中' do
      expect( @zhiyi.add_admin @organ_admin ).to eq [@organ_admin]
      expect( Actor.find_or_create(@zhiyi, Membership.organ_admin).users ).to eq [@organ_admin]
      expect( @zhiyi.add_admin @organ_admin ).to be_nil

      expect( @zhiyi.add_member @organ_admin ).to eq [@organ_admin]
      expect( @zhiyi.add_member @organ_member ).to eq [@organ_admin, @organ_member]
      expect( Actor.find_or_create(@zhiyi, Membership.organ_member).users ).to eq [@organ_admin, @organ_member]
    end
  end

  describe '实例化组织与用户的关系后' do
    before :each do
      @zhiyi_admin_actor = Actor.create(organ_id: @zhiyi.id, membership_id: Membership.organ_admin.id)
      @zhiyi_member_actor = Actor.create(organ_id: @zhiyi.id, membership_id: Membership.organ_member.id)

      [@zhiyi_admin_actor, @zhiyi_member_actor].map { |e| e.users << @organ_admin }
      @zhiyi_member_actor.users << @organ_member

      @organ_member2 = create(:organ_member2)
      @software_member_actor = Actor.create(organ_id: @software.id, membership_id: Membership.organ_member.id)
      @software_member_actor.users << @organ_member2
    end

    it '应该获取到组织的所有成员' do
      expect( @zhiyi.members ).to eq [@organ_admin, @organ_member]
    end

    it '应该获取组织的所有子级成员' do
      expect( @zhiyi.children_members ).to eq [@organ_member2]
    end
  end
end
