# -*- coding: utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:change, :data_submit, :password_submit], User

    can :manage, :all if user.super_user?

    user.members.each do |member|
      can :manage, :all if member.organ.parent.blank? && member.admin?

      if member.admin?
        can [:new, :create], User

        can :show, Organ do |organ|
          user.admin_organ.subtree.include?(organ)
        end
        
        can :manage, User do |u|
          User.joins{members.organ}.where{members.organ.id.in member.organ.subtree.map(&:id)}.include?(u)
        end
      end
    end
  end
end
