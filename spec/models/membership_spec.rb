# -*- coding: utf-8 -*-
require 'spec_helper'

describe Membership do
  before :each do
    SystemRoles.each { |k, membership_name| Membership.create( :name => membership_name).update_attribute(:status, 1) }
  end
  it "以 SystemRoles 的 key 作为方法名来获取 Membership 中相应的角色记录" do
    SystemRoles.each do |method_name, membership_name|
      expect( Membership.send(method_name).name ).to eql membership_name
    end
  end

  it '当 Membership 的 status 为 1 时，表示为系统角色，不能删除' do
    SystemRoles.each do |method_name, membership_name|
      expect( Membership.send(method_name).destroy ).to be_false
    end
  end
end
