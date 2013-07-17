# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  before :each do
    @guest = create(:guest)
    @member = create(:member)
    @organ_admin = create(:organ_admin)
    @system_admin = create(:system_admin)
  end
end