# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rank do
  before :each do
    @qi_ye = create(:qi_ye)
    @bu_men = create :bu_men, parent: @qi_ye
    @ke_shi = create :ke_shi, parent: @bu_men
  end

  it '一个等级下只能有一个子等级' do
    expect( Rank.new( :name => '部门级别', :parent_id => @qi_ye.id ).save ).to be_false
  end
end