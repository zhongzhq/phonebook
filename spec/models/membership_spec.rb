# -*- coding: utf-8 -*-
require 'spec_helper'

describe Membership do
  context 'Callback 测试' do
    it 'Membership 在保存时自动关联指定组织的根组织' do
      @manager = create :manager, :organ_id => create(:zhiyi_software).id
      expect( @manager.organ.name ).to eq build(:zhiyi).name
    end
  end
end
