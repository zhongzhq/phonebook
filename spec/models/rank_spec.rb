# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rank do
  it '不能创建两个 :name 相同的等级' do
    expect( build(:rank).save ).to be_true
    build(:rank).should_not be_valid    
  end
end
