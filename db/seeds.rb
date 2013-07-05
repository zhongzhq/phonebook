# -*- coding: utf-8 -*-
#------- 初始化等级 ----
rank1 = Rank.create!(name: "厅级")
rank11 = Rank.create!(name: "局级",parent_id: rank1.id)
rank12 = Rank.create!(name: "科级",parent_id: rank11.id)

rank2 = Rank.create!(name: "省级")
rank21 = Rank.create!(name: "市级",parent_id: rank2.id)
rank22 = Rank.create!(name: "区县级",parent_id: rank21.id)
