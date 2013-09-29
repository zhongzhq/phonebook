# -*- coding: utf-8 -*-
# 部门初始化
zhiyi = Organ.create!(name: '成都知一软件有限公司' )
  software = Organ.create!(name: '软件研发部', parent_id: zhiyi )
    front = Organ.create!(name: '前台开发部', parent_id: software )
    behind = Organ.create!(name: '后台开发部', parent_id: software )
  testing = organ12 = Organ.create!(name: '测试部', parent_id: zhiyi)
  xingzheng = Organ.create!(name: '行政部', parent_id: zhiyi)
  caiwu = Organ.create!(name: '财务部', parent_id: zhiyi )
  zservice = Organ.create!(name: '极服务', parent_id: zhiyi)

# 角色初始化
member = Membership.create!(name: '成员', organ_id: zhiyi.id)
admin = Membership.create!(name: '管理员', organ_id: zhiyi.id)

# 成员初始化
behind_users = [
  User.create!(name: "苏渝", phone: 18602881279, username: "suyu", password: "123456"),
  User.create!(name: "谢刚", phone: 18628171676, username: "xiegang", password: "123456"),
  User.create!(name: "钟正权", phone: 13551147353, username: "zhongzhengquan", password: "123456"),
  User.create!(name: "杨峻峰", phone: 15881151751, username: "yangjunfeng", password: "123456"),
  User.create!(name: "陈健斌", phone: 15882357025, username: "chenjianbin", password: "123456"),
  User.create!(name: "杨丹", phone: 13281283611, username: "yangdan", password: "123456"),
  User.create!(name: "何源", phone: 13320963363, username: "heyuan", password: "123456"),
  User.create!(name: "黄德洲", phone: 18782902305, username: "huangdezhou", password: "123456"),
  User.create!(name: "张涛", phone: 15202826031, username: "zhangtao", password: "123456"),
  User.create!(name: "尹常鑫", phone: 15184469287, username: "yinchangxin", password: "123456"),
  User.create!(name: "唐久军", phone: 18782943143, username: "tangjiujun", password: "123456")
  ]
  behind_actor = Actor.create!(membership_id: member.id, organ_id: behind.id)
  behind_users.each { |e| e.actors << behind_actor }

testing_users = [
  User.create!(name: "唐浩", phone: 13880129915, username: "tanghao", password: "123456")
  ]
  testing_actor = Actor.create!(membership_id: member.id, organ_id: testing.id)
  testing_users.each { |e| e.actors << testing_actor }

xingzheng_users = [
  User.create!(name: "闫秋云", phone: 13808229662, username: "yanqiuyun", password: "123456")
  ]
  xingzheng_actor = Actor.create!(membership_id: member.id, organ_id: xingzheng.id)
  xingzheng_users.each { |e| e.actors << xingzheng_actor }

caiwu_users = [
  User.create!(name: "刘玲", phone: 13541386053, username: "liuling", password: "123456"),
  User.create!(name: "李佳", phone: 13308176710, username: "lijia", password: "123456")
  ]
  caiwu_actor = Actor.create!(membership_id: member.id, organ_id: caiwu.id)
  caiwu_users.each { |e| e.actors << caiwu_actor }

zservice_users = [
  User.create!(name: "甘华丽", phone: 15281039267, username: "ganhuali", password: "123456"),
  User.create!(name: "周英", phone: 13438800586, username: "zhouying", password: "123456"),
  User.create!(name: "邓宇晶", phone: 18600160167, username: "dengyujing", password: "123456"),
  User.create!(name: "邹瑜", phone: 18008055031, username: "zouyu", password: "123456"),
  User.create!(name: "文靖", phone: 15199925679, username: "wenjing", password: "123456"),
  User.create!(name: "李源冰", phone: 13350081882, username: "liyuanbin", password: "123456"),
  User.create!(name: "廖肖韦", phone: 15202859971, username: "liaoxiaowei", password: "123456"),
  User.create!(name: "钟刘梅", phone: 15196634082, username: "zhongliumei", password: "123456")
 ]
 zservice_actor = Actor.create!(membership_id: member.id, organ_id: zservice.id)
 zservice_users.each { |e| e.actors << zservice_actor }

# 初始化管理员
zhiyi_admin_actor = Actor.create!(membership_id: admin.id, organ_id: zhiyi.id)
['xiegang', 'tangjiujun'].each do |username|
  User.where(:username => username).each { |user| user.actors << zhiyi_admin_actor }
end
