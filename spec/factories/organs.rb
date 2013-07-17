# -*- coding: utf-8 -*-

FactoryGirl.define do
  factory :organ do

    factory :zhiyi do
      name '成都知一软件有限公司'
    end

    factory :software do
      name '软件开发部'
    end

    factory :backgroud do
      name '后台开发部'
    end

    factory :front do
      name '前台开发部'
    end

    factory :test do
      name '软件测试部'
    end

  end
end