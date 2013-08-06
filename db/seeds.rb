# -*- coding: utf-8 -*-

# 系统初始化 权限组
manage_system =  Permission.create!(name: '系统管理', code: 'master',level: 0)
manage_organ = Permission.create!(name: '管理所属企业', code: 'master_organ', level: 1)
read_organ  = Permission.create!(name: '查看所属企业', code: 'read_organ', level: 1)

# 系统初始化 超级管理员
system_group      = Organ.create!(name: "系统管理组" )
system_membership = Membership.create!(name: "超级管理员", organ_id: system_group.id)

system_actor      = Actor.create!(organ_id: system_group.id, membership_id: system_membership.id)
# 将 系统管理组/超级管理员 加入 超级管理员权限组
manage_system.actors << system_actor

system_actor.users << User.create!(name:"谢刚",email:"tianbymy@163.com",password:"123456",password_confirmation:"123456",phone: "18628171676")
