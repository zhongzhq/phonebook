# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :organ do
    factory :zhiyi do
      name '成都知一软件有限公司'
    end

    factory :software do
      name '软件研究部'

      factory :zhiyi_software do
        association :parent, :factory => :zhiyi
      end
    end    

    factory :behind do
      name '后台开发部'

      factory :zhiyi_software_behind do
        association :parent, :factory => :zhiyi_software
      end
    end

    # 系统管理组
    factory :system_organ do
      name Settings.system_organ
    end
  end
end