# -*- coding: utf-8 -*-

# ---------- 初始化本公司数据  测试数据 ----------
rank1 = Rank.create!(name: "企业")

rank11 = Rank.create!(name: "部门",parent_id: rank1)
rank111 = Rank.create!(name: "科室",parent_id: rank11)

membership1 = Membership.create!(name: "总经理")
membership2 = Membership.organ_member
membership3 = Membership.organ_admin
membership4 = Membership.system_admin


organ1 = Organ.create!(name: '成都知一软件有限公司', rank_id: rank1.id )
  organ11 = Organ.create!(name: '软件开发部', rank_id: rank11.id, parent_id: organ1 )
    organ11_1 = Organ.create!(name: '前台开发部', rank_id: rank11.id, parent_id: organ11 )
    # 后台开发部
    organ11_2 = Organ.create!(name: '后台开发部', rank_id: rank11.id, parent_id: organ11 )      
      User.create!(username: "suyu", name: "苏渝", phone: 18602881279, email: "suyu@zhiyisoft.com",password: "18602881279",password_confirmation:  "18602881279")
      User.create!(username: "xiegang", name: "谢刚", phone: 18628171676, email: "xiegang@zhiyisoft.com",password: "18628171676",password_confirmation:  "18628171676")
      User.create!(username: "zhongzhengquan", name: "钟正权", phone: 13551147353, email: "zhongzhengquan@zhiyisoft.com",password: "13551147353",password_confirmation:  "13551147353")
      User.create!(username: "yangjunfeng", name: "杨峻峰", phone: 15881151751, email: "yangjunfeng@zhiyisoft.com",password: "15881151751",password_confirmation:  "15881151751")
      User.create!(username: "chenjianbin", name: "陈健斌", phone: 15882357025, email: "chenjianbin@zhiyisoft.com",password: "15882357025",password_confirmation:  "15882357025")
      User.create!(username: "yangdan", name: "杨丹", phone: 13281283611, email: "yangdan@zhiyisoft.com",password: "13281283611",password_confirmation:  "13281283611")
      User.create!(username: "heyuan", name: "何源", phone: 13320963363, email: "heyuan@zhiyisoft.com",password: "13320963363",password_confirmation:  "13320963363")
      User.create!(username: "recurlamlisp", name: "黄德洲", phone: 18782902305, email: "recurlamlisp@gamil.com",password: "18782902305",password_confirmation:  "18782902305")
      User.create!(username: "zhangtao", name: "张涛", phone: 15202826031, email: "zhangtao@zhiyisoft.com",password: "15202826031",password_confirmation:  "15202826031")
      User.create!(username: "yinchangxin", name: "尹常鑫", phone: 15184469287, email: "yinchangxin@zhiyisoft.com",password: "15184469287",password_confirmation:  "15184469287")
      actor1 = Actor.create!(membership_id: membership2.id, organ_id: organ11_2.id)
      User.all.map { |e| actor1.users << e  }

  # 测试部
  organ12 = Organ.create!(name: '测试部', rank_id: rank11.id, parent_id: organ1)
    actor2 = Actor.create!(membership_id: membership2.id, organ_id: organ12.id)
    User.create!(username: "tanghao", name: "唐浩", phone: 13880129915, email: "tanghao@zhiyisoft.com",password: "13880129915",password_confirmation:  "13880129915")    
    actor2.users << User.last

  # 行政部
  organ13 = Organ.create!(name: '行政部', rank_id: rank11.id, parent_id: organ1)
    actor3 = Actor.create!(membership_id: membership2.id, organ_id: organ13.id)
    User.create!(username: "yanqiuyun", name: "闫秋云", phone: 13808229662, email: "yanqiuyun@zhiyisoft.com",password: "13808229662",password_confirmation:  "13808229662")    
    actor3.users << User.last

  # 财务部
  organ14 = Organ.create!(name: '财务部', rank_id: rank11.id, parent_id: organ1 )
    actor4 = Actor.create!(membership_id: membership2.id, organ_id: organ14.id)
    User.create!(username: "liuling", name: "刘玲", phone: 13541386053, email: "liuling@zhiyisoft.com",password: "13541386053",password_confirmation:  "13541386053")
    actor4.users << User.last
    User.create!(username: "lijia", name: "李佳", phone: 13308176710, email: "lijia@zhiyisoft.com",password: "13308176710",password_confirmation:  "13308176710")
    actor4.users << User.last

# 激活所有账户
# User.all.map { |e| e.update_attribute(:confirmation_token, nil) }

# ---------- 其他测试数据 ----------
organ2 = Organ.create!(name: '成都新东方烹饪学校', rank_id: rank1.id )

User.create!(username: "guest",name:"no enterprise",email:"guest@163.com",password:"123456",password_confirmation:"123456",phone: "123456")

actor1.users << User.create!(username: "member",name:"enterprise member",email:"member@163.com",password:"123456",password_confirmation:"123456",phone: "123456")

actor5 = Actor.create!(membership_id: membership3.id, organ_id: organ1.id)
actor51 = Actor.create!(membership_id: membership2.id, organ_id: organ1.id)
actor5.users << User.create!(username: "tianbymy",name:"xiegang_admin",email:"tianbymy@163.com",password:"adminxg",password_confirmation:"adminxg",phone: "18628171676")
actor51.users << User.last

actor6 = Actor.create!(membership_id: membership4.id)
actor6.users << User.create!(username: "system",name:"system",email:"system_admin@163.com",password:"123456",password_confirmation:"123456",phone: "123456")