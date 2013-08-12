# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :actor do

    trait :zhiyi_organ do
      association :organ, :factory => :zhiyi
    end

    # 下面两个 actor 如果同时使用，属于两个不同的 zhiyi_organ
    factory :zhiyi_admin_actor do
      zhiyi_organ 
      after :build do |actor|
        organ = Organ.find actor.organ_id
        actor.membership_id = Membership.where( :name => build(:admin).name ).first.id
      end
    end
    
    factory :zhiyi_member_actor do
      zhiyi_organ
      after :build do |actor|
        organ = Organ.find actor.organ_id
        actor.membership_id = Membership.where( :name => build(:member).name ).first.id
      end
    end

  end
end