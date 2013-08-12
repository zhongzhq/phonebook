# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :organ do
    factory :zhiyi do
      name '成都知一软件有限公司'

      factory :zhiyi_with_actors do
        after :create do |organ|
          organ.membership_ids.map do |membership_id|
            Actor.create :membership_id => membership_id, :organ_id => organ.id
          end
        end
      end
    end

    factory :software do
      name '软件研究部'

      factory :zhiyi_software do
        association :parent, :factory => :zhiyi

        factory :zhiyi_software_with_actors do
          after :create do |organ|
            organ.root.membership_ids.map do |membership_id|
              Actor.create :membership_id => membership_id, :organ_id => organ.id
            end
          end
        end
      end
    end    

    factory :behind do
      name '后台开发部'

      factory :zhiyi_software_behind do
        association :parent, :factory => :zhiyi_software

        factory :zhiyi_software_behind_with_actors do
          after :create do |organ|
            organ.root.membership_ids.map do |membership_id|
              Actor.create :membership_id => membership_id, :organ_id => organ.id
            end
          end
        end
      end
    end

    # 系统管理组
    factory :system_organ do
      name Settings.system_organ

      factory :system_organ_with_actors do
        after :create do |organ|
          organ.membership_ids.map do |membership_id|
            Actor.create :membership_id => membership_id, :organ_id => organ.id
          end
        end
      end
    end
  end
end