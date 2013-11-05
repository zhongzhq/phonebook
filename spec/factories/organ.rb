# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :organ do
    factory :zhi_yi do
      name "成都知一软件有限公司"
      sort 80
    end

    factory :ruan_jian do
      name "软件研发部"
      sort 60

      association :parent, :factory => :zhi_yi
    end

    factory :hou_tai do
      name "后台开发部"
      sort 40
      
      association :parent, :factory => :ruan_jian
    end
  end
end