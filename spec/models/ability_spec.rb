# -*- coding: utf-8 -*-
require 'spec_helper'

describe Ability do
  before :each do
    # 角色
    Settings.system_roles.each { |key, value| Membership.create!( :name => value ).update_attribute(:status, 1) }

    # 用户
    @system_admin = create :system_admin
    @guest = create :guest

    # Actor
    @system_admin_actor = Actor.create(membership_id: Membership.system_admin.id)
    @system_admin_actor.users << @system_admin
  end

  describe "以系统管理员身份登陆" do
    before :each do
      @ability = Ability.new(@system_admin)
    end

    it '应该可以访问管理员首页' do
      @ability.should be_able_to(:manage, :default)
    end

    it '应该可以管理等级 和 角色' do    
      @ability.should be_able_to(:manage, Rank.new)
      @ability.should be_able_to(:manage, Membership.new)
    end

    it '应该可以管理企业' do
      @ability.should be_able_to(:manage, :organ)
    end
        
  end
end