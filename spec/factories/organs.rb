# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :organ do

    factory :zhiyi do
      name '成都知一软件有限公司'
    end

      factory :software do
        name '软件研究部'
      end

        factory :behind do
          name '后台开发部'
        end

    factory :baidu do
      name '百度'
    end

    factory :system_organ do
      name Settings.system_organ
    end

  end
end