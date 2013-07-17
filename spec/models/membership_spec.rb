# -*- coding: utf-8 -*-
require 'spec_helper'

describe Membership do
  before :each do
    @organ_member = create(:organ_member_membership)
    @organ_admin = create(:organ_admin_membership)
    @system_admin = create(:system_admin_membership)
  end
end