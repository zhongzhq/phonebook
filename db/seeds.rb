# -*- coding: utf-8 -*-
#------- 初始化等级 ------
rank1 = Rank.create!(name: "厅级")
rank11 = Rank.create!(name: "局级",parent_id: rank1.id)
rank111 = Rank.create!(name: "科级",parent_id: rank11.id)

rank2 = Rank.create!(name: "省级")
rank21 = Rank.create!(name: "市级",parent_id: rank2.id)
rank211 = Rank.create!(name: "区县级",parent_id: rank21.id)

membership = Membership.create!(name: "企业用户")
membership1 = Membership.create!(name: "系统用户",status: 0)




#------- 初始化组织机构 测试数据----
organ1 = Organ.create!(name: '知一软件有限公司', rank_id: rank1.id )
organ11 = Organ.create!(name: '软件开发部', rank_id: rank11.id, parent_id: organ1.id )
organ111 = Organ.create!(name: 'IOS 开发部', rank_id: rank111.id, parent_id: organ11.id )
organ112 = Organ.create!(name: 'Android 开发部', rank_id: rank111.id, parent_id: organ11.id )
organ12 = Organ.create!(name: '运维部', rank_id: rank11.id, parent_id: organ1.id )
