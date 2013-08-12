# -*- coding: utf-8 -*-
require 'spec_helper'

describe Organ do
  context '自定义验证' do
    it '同一父级的组织名不能重复' do
      @zhiyi_software = create :zhiyi_software
      expect( -> { build :zhiyi_software } ).to raise_error ActiveRecord::RecordInvalid
    end
  end
end
