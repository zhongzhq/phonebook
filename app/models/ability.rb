# -*- coding: utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    read_organ unless user.organs.empty?

    user.permissions.each do |permission|
      eval permission.code
    end

    can :render_event_response, :all

  end

  # 定义 3 种权限
  private

  def master
    can :manage ,:all
  end

  def master_organ
    can :manage, Organ
    can :manage, Membership
  end

  def read_organ
    can :read, Organ
  end

end
