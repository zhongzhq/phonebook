# -*- coding: utf-8 -*-
require 'spec_helper'

describe Membership do
  it "可以 I18n.t('phonebook.membership'') 的 键 作为方法名来获取 以其值作为 membership 的 name 的记录" do
    I18n.t("phonebook.membership").each { |k, v| Membership.create(name: v) }

    I18n.t("phonebook.membership").each do |k, v|
      expect(Membership.send(k).name).to eql v
    end
  end
end
