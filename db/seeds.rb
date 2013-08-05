# -*- coding: utf-8 -*-

# 系统初始化 权限组
system_group_permission =  Permission.create!(name: '超级管理员组', code: 'master',level: 0)
en_organ_manage = Permission.create!(name: '管理所属企业', code: 'organ_master', level: 1)
en_organ_read   = Permission.create!(name: '查看所属企业', code: 'organ_read', level: 1)

# 系统初始化 超级管理员
system_group      = Organ.create!(name: "系统管理组" )
system_membership = Membership.create!(name: "超级管理员", organ_id: system_group.id)
system_actor      = Actor.create!(organ_id: system_group.id, membership_id: system_membership.id)
system_actor.users << User.create!(name:"谢刚",email:"tianbymy@163.com",password:"123456",password_confirmation:"123456",phone: "18628171676")


# 将 系统管理组/超级管理员 加入 超级管理员权限组
system_group_permission.actors << system_actor


