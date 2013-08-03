# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :membership do

    factory :member do
      name Settings.member
    end

    factory :admin do
      name Settings.admin
    end

    factory :manager do
      name '经理'
    end

  end
end