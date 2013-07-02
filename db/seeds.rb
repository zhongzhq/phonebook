# -*- coding: utf-8 -*-
rank1 = Unirole::Rank.create(name: '企业')
rank2 = Unirole::Rank.create(name: '部门', parent: rank1)

membership1 = Unirole::Membership.create(name: '系统管理员')
membership2 = Unirole::Membership.create(name: '成员')

organ1 = Unirole::Organ.create(rank: rank1, name: '成都知一软件有限公司')
organ2 = Unirole::Organ.create(rank: rank2, name: '软件开发部', parent: organ1)
organ3 = Unirole::Organ.create(rank: rank2, name: '后勤服务部', parent: organ1)

actor_admin = Unirole::Actor.find_or_create_by(membership: membership1,organ: organ4)
actor_admin.user << Unirole::User.create(sn: '谢', cn: '刚',login: 'xiegang')

actor_user = Unirole::Actor.find_or_create_by(membership: membership2,organ: organ4)
actor_user.user << Unirole::User.create(sn: '谢', cn: '刚',login: 'xiegang')
