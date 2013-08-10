# -*- coding: utf-8 -*-
require 'spec_helper'

describe Organ do
  context '类方法测试' do
    context '调用 available_organs 方法' do
      it '应该获得所有通过审核的顶级组织' do
        @system_organ = create :system_organ
        @zhiyi = create :zhiyi
        expect( Organ.available_organs ).to be_empty

        @zhiyi.pass
        Organ.available_organs.should include @zhiyi
        Organ.available_organs.should_not include @system_organ
      end

      it '应该不包含子级组织' do
        create :zhiyi_software
        Organ.available_organs.should be_empty
      end
    end

    it '调用 system_organ 应该返回系统管理组顶级的记录' do
      @system_organ = create :system_organ
      expect( Organ.system_organ ).to eq @system_organ
    end
  end

  context 'Callback 测试' do
    it '系统管理组信息不能修改' do
      @system_organ = create :system_organ
      expect( @system_organ.update_attributes(:name => 'test')).to be_false
    end

    it '顶级组织在创建后自动初始化组织基本角色' do
      @zhiyi = create :zhiyi      
      expect( @zhiyi.memberships.size ).to eq 2      
    end

    it '非顶级组织在创建后，应该不会自动初始化组织基本角色' do
      @zhiyi_software = create :zhiyi_software
      expect( @zhiyi_software.memberships ).to be_empty
    end

    it '子级组织在保存后自动通过' do
      @zhiyi_software = create :zhiyi_software
      expect( @zhiyi_software.success? ).to be_true
    end
  end

  context '自定义验证' do
    it '同一父级的组织名不能重复' do
      @zhiyi_software = create :zhiyi_software
      expect( -> { build :zhiyi_software } ).to raise_error ActiveRecord::RecordInvalid
    end
  end
end
