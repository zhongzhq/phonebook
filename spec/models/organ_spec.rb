# -*- coding: utf-8 -*-
require 'spec_helper'

describe Organ do
  it "返回组织的全名" do
    FactoryGirl.build(:zhi_yi).fullname.should eq "成都知一软件有限公司"
    FactoryGirl.build(:hou_tai).fullname.should eq "成都知一软件有限公司/软件研发部/后台开发部"
  end
end