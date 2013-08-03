# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  before :each do
    @zhiyi_software_behind = create :zhiyi_software_behind_with_actors, :parent => create(:zhiyi_software_with_actors)    
    # user
    @guest_user = create :guest_user
    @behind_user_one = create :behind_user_one
    @behind_user_two = create :behind_user_two
    
    # add user to actor
    @zhiyi_software_behind.actors.each { |e| [@behind_user_one, @behind_user_two].map { |x| e.users << x } }
  end

  it '调用 find_by_organ，应该返回指定组织下的所有用户' do
    expect( User.find_by_organ @zhiyi_software_behind ).to eq [@behind_user_one, @behind_user_two]
  end

  it '调用 organs，应该返回用户的加入的所有组织返回用户所属的组织' do
    expect( @behind_user_one.organs ).to eq [@zhiyi_software_behind]

    @zhiyi_software_behind.parent.actors.each { |e| e.users << @behind_user_one }
    expect( User.find(@behind_user_one.id).organs ).to eq [@zhiyi_software_behind.parent, @zhiyi_software_behind]
  end
end
