# -*- coding: utf-8 -*-
require 'spec_helper'

describe Ability do
  let(:ability) { Ability.new(create :guest_user) }
  it '所有用户可以申请企业，或者申请加入企业' do
    ability.should be_able_to(:apply, Organ)
  end

  describe '普通企业成员' do
    before :each do
      @behind_user_one = create :behind_user_one

      @zhiyi_software_behind = create :zhiyi_software_behind_with_actors      
      Actor.find_by_organ_and_membership(
        @zhiyi_software_behind, Membership.organ_member(@zhiyi_software_behind)
        ).tap do |x|
        x.users << @behind_user_one
        x.permissions << (create :read_organ)
      end
    end

    let(:ability) { Ability.new(@behind_user_one) }
    it '可以查看所属企业' do
      ability.should be_able_to(:read, Organ)
    end
  end

  describe '企业管理员' do
    before :each do
      @zhiyi_admin_user = create :zhiyi_admin_user

      @zhiyi_software_behind = create :zhiyi_software_behind_with_actors      
      Actor.find_by_organ_and_membership(
        @zhiyi_software_behind, Membership.organ_admin(@zhiyi_software_behind)
        ).tap do |x|
        x.users << @zhiyi_admin_user
        x.permissions << (create :manage_organ)
      end
    end

    let(:ability) { Ability.new(@zhiyi_admin_user) }
    it '可以查看所属企业' do
      ability.should be_able_to(:manage, Organ)
    end
  end

  describe '系统管理员' do
    before :each do
      @system_admin_user = create :system_admin_user

      @zhiyi_software_behind = create :zhiyi_software_behind_with_actors      
      Actor.find_by_organ_and_membership(
        @zhiyi_software_behind, Membership.organ_admin(@zhiyi_software_behind)
        ).tap do |x|
        x.users << @system_admin_user
        x.permissions << (create :manage_all)
      end
    end

    let(:ability) { Ability.new(@system_admin_user) }
    it '可以查看所属企业' do
      ability.should be_able_to(:manage, :all)
    end
  end
end
