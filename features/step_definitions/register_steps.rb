# -*- coding: utf-8 -*-

假如(/^我访问首页$/) do
  visit root_path
end

那么(/^我应该看到 "(.*?)"$/) do |arg1|
  page.should have_content arg1
end

当(/^我点击链接 "(.*?)"$/) do |arg1|
  click_on arg1
end