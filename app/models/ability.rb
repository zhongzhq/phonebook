# -*- coding: utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # alias action form organ
    alias_action :create, :join, :join_create, :render_event_response, :to => :apply

    user.permissions.each do |permission|
      eval permission.code
    end

    can :apply, Organ
  end

# 定义3种权限
  private

  def master
    can :manage ,:all
  end

  def organ_master
    can manage,Organ
    can manage,Membership
  end

  def organ_read
    can read,Organ
    can read,Membership
  end


end
