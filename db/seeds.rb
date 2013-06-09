# -*- coding: utf-8  -*-
rank1 = Unirole::Rank.create(name: '企业')
rank2 = Unirole::Rank.create(name: '部门', parent: rank1)


membership1 = Unirole::Membership.create!(:name => '系统管理员')
membership2 = Unirole::Membership.create!(:name => '成员')
en = Unirole::Organ.create!(name: '成都知一软件有限公司', rank: rank1, parent: nil, order: 1)
Unirole::Organ.create!(name: '软件开发部', rank: rank2, parent: en, order: 1)
Unirole::Organ.create!(name: '后勤行政部', rank: rank2, parent: en, order: 2)
