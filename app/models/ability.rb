# -*- coding: utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :index, Organ
    can [:show, :with_organ_show], User
  end
end
