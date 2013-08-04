# -*- coding: utf-8 -*-

# ---------- 系统初始化数据 ----------
# 初始化 系统管理组
system_organ = Organ.create!(name: Settings.system_organ )

# 权限初始化
all =  Permission.new(name: '管理系统', code: 'can :manage, :all')
manage_organ = Permission.new(name: '管理所属企业', code: '
  can :manage, Organ do |organ|
    user.root_organ == organ.root
  end', level: 0)
read_organ = Permission.new(name: '查看所属企业', code: '
  can :read, Organ do |organ|
    user.root_organ == organ.root
  end
  ', level: 0)

# ---------- 初始化本公司数据  测试数据 ----------
organ1 = Organ.create!(name: '成都知一软件有限公司' )

# 初始化公司角色
membership1 = Membership.organ_member(organ1)
membership2 = Membership.organ_admin(organ1)
membership3 = Membership.organ_admin(system_organ)

  organ11 = Organ.create!(name: '软件开发部', parent_id: organ1 )
    organ11_1 = Organ.create!(name: '前台开发部', parent_id: organ11 )
    # 后台开发部
    organ11_2 = Organ.create!(name: '后台开发部', parent_id: organ11 )
      User.create!(name: "苏渝", phone: 18602881279, email: "suyu@zhiyisoft.com",password: "18602881279",password_confirmation:  "18602881279")
      User.create!(name: "谢刚", phone: 18628171676, email: "xiegang@zhiyisoft.com",password: "18628171676",password_confirmation:  "18628171676")
      User.create!(name: "钟正权", phone: 13551147353, email: "zhongzhengquan@zhiyisoft.com",password: "13551147353",password_confirmation:  "13551147353")
      User.create!(name: "杨峻峰", phone: 15881151751, email: "yangjunfeng@zhiyisoft.com",password: "15881151751",password_confirmation:  "15881151751")
      User.create!(name: "陈健斌", phone: 15882357025, email: "chenjianbin@zhiyisoft.com",password: "15882357025",password_confirmation:  "15882357025")
      User.create!(name: "杨丹", phone: 13281283611, email: "yangdan@zhiyisoft.com",password: "13281283611",password_confirmation:  "13281283611")
      User.create!(name: "何源", phone: 13320963363, email: "heyuan@zhiyisoft.com",password: "13320963363",password_confirmation:  "13320963363")
      User.create!(name: "黄德洲", phone: 18782902305, email: "recurlamlisp@gamil.com",password: "18782902305",password_confirmation:  "18782902305")
      User.create!(name: "张涛", phone: 15202826031, email: "zhangtao@zhiyisoft.com",password: "15202826031",password_confirmation:  "15202826031")
      User.create!(name: "尹常鑫", phone: 15184469287, email: "yinchangxin@zhiyisoft.com",password: "15184469287",password_confirmation:  "15184469287")
      actor1 = Actor.create!(membership_id: membership1.id, organ_id: organ11_2.id)     
      User.all.map { |e| actor1.users << e  }

  # 测试部
  organ12 = Organ.create!(name: '测试部', parent_id: organ1)
    actor2 = Actor.create!(membership_id: membership1.id, organ_id: organ12.id)
    User.create!(name: "唐浩", phone: 13880129915, email: "tanghao@zhiyisoft.com",password: "13880129915",password_confirmation:  "13880129915")
    actor2.users << User.last

  # 行政部
  organ13 = Organ.create!(name: '行政部', parent_id: organ1)
    actor3 = Actor.create!(membership_id: membership1.id, organ_id: organ13.id)
    User.create!(name: "闫秋云", phone: 13808229662, email: "yanqiuyun@zhiyisoft.com",password: "13808229662",password_confirmation:  "13808229662")
    actor3.users << User.last

  # 财务部
  organ14 = Organ.create!(name: '财务部', parent_id: organ1 )
    actor4 = Actor.create!(membership_id: membership1.id, organ_id: organ14.id)
    User.create!(name: "刘玲", phone: 13541386053, email: "liuling@zhiyisoft.com",password: "13541386053",password_confirmation:  "13541386053")
    actor4.users << User.last
    User.create!(name: "李佳", phone: 13308176710, email: "lijia@zhiyisoft.com",password: "13308176710",password_confirmation:  "13308176710")
    actor4.users << User.last

Organ.all.map { |e| e.pass }
Actor.all.map { |e| e.permissions << read_organ }

# ---------- 其他测试数据 ----------
organ2 = Organ.create!(name: '成都大学' )

User.create!(name:"no enterprise",email:"guest@163.com",password:"123456",password_confirmation:"123456",phone: "12345612345")

actor1.users << User.create!(name:"enterprise member",email:"member@163.com",password:"123456",password_confirmation:"123456",phone: "12345612346")

actor5 = Actor.create!(membership_id: membership2.id, organ_id: organ1.id)
actor5.permissions << read_organ
actor51 = Actor.create!(membership_id: membership1.id, organ_id: organ1.id)
actor51.permissions << manage_organ
actor5.users << User.create!(name:"知一软件-谢刚",email:"tianbymy@163.com",password:"adminxg",password_confirmation:"adminxg",phone: "18628171674")
actor51.users << User.last

actor6 = Actor.create!(membership_id: membership3.id, organ_id: system_organ.id)
actor6.permissions << all
actor6.users << User.create!(name:"知一软件系统管理员",email:"system_admin@163.com",password:"123456",password_confirmation:"123456",phone: "12345612347")

# 激活所有账户
User.all.map { |e| e.update_attribute(:confirmation_token, nil) }
User.all.map { |e| e.update_attribute(:confirmed_at, Time.now) }