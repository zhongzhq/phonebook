# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :permission do

    factory :manage_all do
      name '管理系统'
      code 'can :manage, :all'
    end

    factory :manage_organ do
      name '管理所属企业'
      code '
      can :manage, Organ do |organ|
        user.root_organ == organ.root
      end
      '
      level 0
    end

    factory :read_organ do
      name '查看所属企业'
      code '
      can :read, Organ do |organ|
        user.root_organ == organ.root
      end
      '
      level 0
    end

  end
end