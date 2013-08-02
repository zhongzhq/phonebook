# -*- coding: utf-8 -*-
require 'spec_helper'

describe Membership do
  before :each do
    # 企业组织
    @zhiyi = create :zhiyi
    @software = create :software, parent_id: @zhiyi.id
  end
  
  it 'Membership 在保存时需要一个关联一个根组织' do
    @zhiyi_admin = create :zhiyi_admin, organ_id: @software.id
    expect( @zhiyi_admin.organ ).to eq @zhiyi
  end
end
