# -*- coding: utf-8 -*-

#------- 初始化本公司数据  测试数据----
rank1 = Rank.create!(name: "企业")

rank11 = Rank.create!(name: "部门",parent_id: rank1)
rank111 = Rank.create!(name: "科室",parent_id: rank11)

membership1 = Membership.create!(name: "总经理")
membership2 = Membership.create!(name: "成员")
membership3 = Membership.create!(name: "管理员")
membership4 = Membership.create!(name: "系统管理员")


organ1 = Organ.create!(name: '成都知一软件有限公司', rank_id: rank1.id )
  organ11 = Organ.create!(name: '软件开发部', rank_id: rank11.id, parent_id: organ1 )
    organ11_1 = Organ.create!(name: '前台开发部', rank_id: rank11.id, parent_id: organ11 )
    organ11_2 = Organ.create!(name: '后台开发部', rank_id: rank11.id, parent_id: organ11 )
  organ12 = Organ.create!(name: '测试部', rank_id: rank11.id, parent_id: organ1)
  organ13 = Organ.create!(name: '行政部', rank_id: rank11.id, parent_id: organ1)
  organ14 = Organ.create!(name: '财务部', rank_id: rank11.id, parent_id: organ1 )




@user = User.create!(account: "tianbymy",email:"tianbymy@163.com",name:"1",password:"adminxg",password_confirmation:"adminxg",phone: "18628171676")
@actor = Actor.create!(membership_id: membership2.id,organ_id: organ11_2.id)
@actor.users << @user

=begin

User.create!(account: "suyu", name: "苏渝",membership_id: membership1.id,organ_id: organ1.id, phone: 18602881279, email: "suyu@zhiyisoft.com",password: "18602881279",password_confirmation:  "18602881279")
User.create!(account: "xiegang", name: "谢刚",membership_id: membership2.id,organ_id: organ11.id, phone: 18628171676, email: "xiegang@zhiyisoft.com",password: "18628171676",password_confirmation:  "18628171676")
User.create!(account: "zhongzhengquan", name: "钟正权",membership_id: membership2.id,organ_id: organ11.id, phone: 13551147353, email: "zhongzhengquan@zhiyisoft.com",password: "13551147353",password_confirmation:  "13551147353")
User.create!(account: "yangjunfeng", name: "杨峻峰",membership_id: membership2.id,organ_id: organ11.id, phone: 15881151751, email: "yangjunfeng@zhiyisoft.com",password: "15881151751",password_confirmation:  "15881151751")
User.create!(account: "chenjianbin", name: "陈健斌",membership_id: membership2.id,organ_id: organ11.id, phone: 15882357025, email: "chenjianbin@zhiyisoft.com",password: "15882357025",password_confirmation:  "15882357025")
User.create!(account: "yangdan", name: "杨丹",membership_id: membership2.id,organ_id: organ11.id, phone: 13281283611, email: "yangdan@zhiyisoft.com",password: "13281283611",password_confirmation:  "13281283611")
User.create!(account: "heyuan", name: "何源",membership_id: membership2.id,organ_id: organ11.id, phone: 13320963363, email: "heyuan@zhiyisoft.com",password: "13320963363",password_confirmation:  "13320963363")
User.create!(account: "recurlamlisp", name: "黄德洲",membership_id: membership2.id,organ_id: organ11.id, phone: 18782902305, email: "recurlamlisp@gamil.com",password: "18782902305",password_confirmation:  "18782902305")
User.create!(account: "zhangtao", name: "张涛",membership_id: membership2.id,organ_id: organ11.id, phone: 15202826031, email: "zhangtao@zhiyisoft.com",password: "15202826031",password_confirmation:  "15202826031")
User.create!(account: "yinchangxin", name: "尹常鑫",membership_id: membership2.id,organ_id: organ11.id, phone: 15184469287, email: "yinchangxin@zhiyisoft.com",password: "15184469287",password_confirmation:  "15184469287")
User.create!(account: "tanghao", name: "唐浩",membership_id: membership2.id,organ_id: organ12.id, phone: 13880129915, email: "tanghao@zhiyisoft.com",password: "13880129915",password_confirmation:  "13880129915")
User.create!(account: "yanqiuyun", name: "闫秋云",membership_id: membership2.id,organ_id: organ13.id, phone: 13808229662, email: "yanqiuyun@zhiyisoft.com",password: "13808229662",password_confirmation:  "13808229662")
User.create!(account: "liuling", name: "刘玲",membership_id: membership2.id,organ_id: organ14.id, phone: 13541386053, email: "liuling@zhiyisoft.com",password: "13541386053",password_confirmation:  "13541386053")
User.create!(account: "lijia", name: "李佳",membership_id: membership2.id,organ_id: organ14.id, phone: 13308176710, email: "lijia@zhiyisoft.com",password: "13308176710",password_confirmation:  "13308176710")


User.create!(account: "tianbymy", name: "谢刚",membership_id: membership2.id,organ_id: organ11.id, phone: 18628171676, email: "tianbymy@163.com",password: "adminxg",password_confirmation:  "adminxg")

=end

