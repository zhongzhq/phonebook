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

    @organ_member = create(:organ_member_membership)
    @organ_admin = create(:organ_admin_membership)

    @member = create(:member)
    @organ_admin = create(:organ_admin)

    @zhiyi_admin_actor = Actor.create(organ: @zhiyi, membership: @organ_admin)
    @zhiyi_admin_member = Actor.create(organ: @zhiyi, membership: @organ_member)
    @backgroud_member_actor = Actor.create(organ: @backgroud, membership: @organ_member)

    [@zhiyi_admin_actor, @zhiyi_admin_member].map { |e| e.users << @organ_admin }
    @backgroud_member_actor.users << @member
  end
end