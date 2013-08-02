# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :membership do

    factory :zhiyi_admin do
      name '知一软件 - 管理员'
    end

    factory :zhiyi_member do
      name '知一软件 - 成员'
    end

  end
end