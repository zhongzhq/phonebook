# -*- coding: utf-8 -*-
require 'spec_helper'

describe Rank do
  before :each do
    @qi_ye = create(:qi_ye)
    @bu_men = create :bu_men, parent: @qi_ye
    @ke_shi = create :ke_shi, parent: @bu_men
  end
end