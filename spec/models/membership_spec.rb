# -*- coding: utf-8 -*-
require 'spec_helper'

describe Membership do
  it 'Membership 在保存时需要一个关联一个根组织' do
    create :zhiyi_admin
    expect( Membership.last.organ ).to eq Organ.last
  end
end
