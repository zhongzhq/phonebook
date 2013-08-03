# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :actor do

    trait :zhiyi_organ do
      association :organ, :factory => :zhiyi
    end

    # 创建组织，并同时初始化 actors，但返回的是组织
    factory :zhiyi_actors, :class => Organ do
      name '成都知一软件有限公司'

      after :create do |organ|
        organ.membership_ids.map do |membership_id|
          Actor.create :membership_id => membership_id, :organ_id => organ.id
        end
      end
    end

    # 下面两个 actor 如果同时使用，属于两个不同的 zhiyi_organ
    factory :zhiyi_admin_actor do
      zhiyi_organ 
      after :build do |actor|
        organ = Organ.find actor.organ_id
        actor.membership_id = Membership.organ_admin( organ ).id
      end
    end
    factory :zhiyi_member_actor do
      zhiyi_organ
      after :build do |actor|
        organ = Organ.find actor.organ_id
        actor.membership_id = Membership.organ_member( organ ).id
      end
    end

  end
end