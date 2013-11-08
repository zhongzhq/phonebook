# -*- coding: utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:index, :show, :search], Organ
    can [:change, :data_submit, :password_submit], User
    can [:show, :with_organ], User

    user.members.each do |member|
      can :manage, :all if member.organ.parent.blank? && member.admin?

      if member.admin?
        can [:new, :create], User
        can :manage, User do |u|
          User.joins{members.organ}.where{members.organ.id.in member.organ.subtree.map(&:id)}.include?(u)
        end
      end
    end
  end
end
