# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :user do
    password '12345678'
    password_confirmation '12345678'

    trait :email_and_phone do
      sequence(:email) {|n| "person#{n}@example.com" }
      sequence(:phone){|n| "1234567890#{n}"}
    end

    [:guest_user, :behind_user_one, :behind_user_two, :zhiyi_admin_user, :system_admin_user].each do |user|
      factory user do
        email_and_phone
      end
    end
  end
end
