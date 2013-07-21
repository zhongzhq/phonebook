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

  it '系统管理员可以管理 等级 和 角色' do
    @ability = Ability.new(@system_admin)
    @ability.should be_able_to(:manage, Membership.new)
    @ability.should be_able_to(:manage, Rank.new)
  end
end