# -*- coding: utf-8 -*-
require 'spec_helper'

describe Membership do
  context '类方法测试' do
    it '调用 organ_member 时，应该返回指定 organ 的 member 角色记录' do
      @zhiyi_software = create :zhiyi_software
      expect( Membership.organ_member(@zhiyi_software).name ).to eq build(:member).name
    end

    it '调用 organ_admin 时，应该返回指定 organ 的 admin 角色记录' do
      @zhiyi_software = create :zhiyi_software
      expect( Membership.organ_admin(@zhiyi_software).name ).to eq build(:admin).name
    end
  end

  context 'Callback 测试' do
    it 'Membership 在保存时自动关联指定组织的根组织' do
      @manager = create :manager, :organ_id => create(:zhiyi_software).id
      expect( @manager.organ.name ).to eq build(:zhiyi).name
    end

    it '每个组织的初始化角色不能修改' do
      expect( Membership.organ_member(create :zhiyi).update_attributes(:name => 'test') ).to be_false
      expect( Membership.organ_admin(create :zhiyi).update_attributes(:name => 'test') ).to be_false
    end

    it '如果不是组织的初始化角色，则可以修改' do
      @manager = create :manager, :organ_id => create(:zhiyi_software).id
      expect( @manager.update_attributes(:name => 'test') ).to be_true
    end
  end
end
