# -*- coding: utf-8 -*-
require 'spec_helper'

describe Actor do
  context '类方法测试' do
    describe '调用 first_or_create 方法时' do
      before :each do
        @zhiyi_admin_actor = create :zhiyi_admin_actor
        @zhiyi = Organ.find(:first, :conditions => { :name => build(:zhiyi).name })        
      end
      
      it '如果 actor 存在，则应该返回对应的 actor 记录' do
        @admin_membership = Membership.organ_admin @zhiyi
        expect( Actor.first_or_create( :organ => @zhiyi, :membership => @admin_membership) ).to eq @zhiyi_admin_actor
      end

      context '如果 actor 不存在' do
        it '当查找的 actor 的 organ 和 membership 同属于一个顶级组织时，应该自动创建 actor 并返回' do
          @member_membership = Membership.organ_member @zhiyi
          expect( Actor.first_or_create( :organ => @zhiyi, :membership => @member_membership).membership ).to eq @member_membership
        end

        it '当查找的 actor 的 organ 和 membership 不属于一个顶级组织时，应该返回 nil' do
          @member_membership = Membership.organ_member @zhiyi
          expect( Actor.first_or_create( :organ => create(:system_organ), :membership => @member_membership) ).to be_nil
        end
      end
    end

    it '调用 find_by_organ 时，应该返回指定 organ 下的所有 actor 记录' do
      @zhiyi_software_behind = create :zhiyi_software_behind_with_actors
      expect( Actor.find_by_organ( @zhiyi_software_behind ).size ).to eq 2
    end
  end
end
