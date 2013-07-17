# -*- coding: utf-8 -*-

FactoryGirl.define do
  factory :user do
    password '123456'
    password_confirmation '123456'

    factory :guest do
      name '游客'
      username 'guest'
      phone '18782943143'
      email 'guest@zhiyisoft.com'
    end

    factory :member do
      name '组织成员'
      username 'member'
      phone '18782943144'
      email 'member@zhiyisoft.com'
    end

    factory :organ_admin do
      name '组织管理员'
      username 'organ_admin'
      phone '18782943145'
      email 'organ_admin@zhiyisoft.com'
    end

    factory :system_admin do
      name '系统管理员'
      username 'system_admin'
      phone '18782943146'
      email 'system_admin@zhiyisoft.com'
    end
  end
end
