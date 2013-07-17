# -*- coding: utf-8 -*-

FactoryGirl.define do
  factory :membership do

    factory :organ_member_membership do
      name '组织成员'
    end

    factory :organ_admin_membership do
      name '组织管理员'
    end

    factory :system_admin_membership do
      name '系统管理员'
    end

  end
end