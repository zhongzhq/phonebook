# -*- coding: utf-8 -*-
require 'spec_helper'

describe Organ do
  before :each do
    @qi_ye = create(:qi_ye)
    @bu_men = create :bu_men, parent: @qi_ye
    @ke_shi = create :ke_shi, parent: @bu_men

    @zhiyi = create :zhiyi, rank: @qi_ye
    @software = create :software, rank: @bu_men, parent: @zhiyi
    @backgroud = create :backgroud, rank: @ke_shi, parent: @software
    @front = create :front, rank: @ke_shi, parent: @software
    @test = create :test, rank: @bu_men, parent: @zhiyi
  end
end