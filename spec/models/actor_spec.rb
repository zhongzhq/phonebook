# -*- coding: utf-8 -*-
require 'spec_helper'

describe Actor do
  context '类方法测试' do
    it '调用 find_by_organ_and_membership 时，应该返回对应的 actor 记录' do
      @zhiyi_admin_actor = create :zhiyi_admin_actor

      @zhiyi = Organ.find(:first, :conditions => { :name => build(:zhiyi).name })
      @member_membership = Membership.organ_member @zhiyi
      @admin_membership = Membership.organ_admin @zhiyi

      expect( Actor.find_by_organ_and_membership @zhiyi, @member_membership ).to be nil
      expect( Actor.find_by_organ_and_membership @zhiyi, @admin_membership ).to eq @zhiyi_admin_actor
    end

    it '调用 find_by_organ 时，应该返回指定 organ 下的所有 actor 记录' do
      @zhiyi = create :zhiyi_actors
      expect( Actor.find_by_organ( @zhiyi ).size ).to eq 2
    end
  end
end
