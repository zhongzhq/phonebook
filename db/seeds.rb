# -*- coding: utf-8 -*-

# ----------------- zhiyi init ------------------
# 部门初始化
zhiyi = Organ.create!(name: '成都知一软件有限公司' )
  software = Organ.create!(name: '软件研发部', parent_id: zhiyi )
    front = Organ.create!(name: '前台开发部', parent_id: software )
    behind = Organ.create!(name: '后台开发部', parent_id: software )
  testing = Organ.create!(name: '测试部', parent_id: zhiyi)
  xingzheng = Organ.create!(name: '行政部', parent_id: zhiyi)
  caiwu = Organ.create!(name: '财务部', parent_id: zhiyi )
  zservice = Organ.create!(name: '极服务', parent_id: zhiyi)

# 角色初始化
member = Job.create!(name: '成员')
admin = Job.create!(name: '管理员')

# 成员初始化
behind_users = [
  User.create!(name: "苏渝", phone: 18602881279, account: "suyu", password: "123456"),
  User.create!(name: "谢刚", phone: 18628171676, account: "xiegang", password: "123456"),
  User.create!(name: "钟正权", phone: 13551147353, account: "zhongzhengquan", password: "123456"),
  User.create!(name: "杨峻峰", phone: 15881151751, account: "yangjunfeng", password: "123456"),
  User.create!(name: "陈健斌", phone: 15882357025, account: "chenjianbin", password: "123456"),
  User.create!(name: "杨丹", phone: 13281283611, account: "yangdan", password: "123456"),
  User.create!(name: "何源", phone: 13320963363, account: "heyuan", password: "123456"),
  User.create!(name: "黄德洲", phone: 18782902305, account: "huangdezhou", password: "123456"),
  User.create!(name: "张涛", phone: 15202826031, account: "zhangtao", password: "123456"),
  User.create!(name: "尹常鑫", phone: 15184469287, account: "yinchangxin", password: "123456"),
  User.create!(name: "唐久军", phone: 18782943143, account: "tangjiujun", password: "tang")
  ]
  behind_users.each { |e| Member.create!(:user_id => e.id, :organ_id => behind.id).tap{|x| x.set_jobs([member.id])} }

testing_users = [
  User.create!(name: "唐浩", phone: 13880129915, account: "tanghao", password: "123456")
  ]
  testing_users.each { |e| Member.create!(:user_id => e.id, :organ_id => testing.id).tap{|x| x.set_jobs([member.id])} }

xingzheng_users = [
  User.create!(name: "闫秋云", phone: 13808229662, account: "yanqiuyun", password: "123456")
  ]
  xingzheng_users.each { |e| Member.create!(:user_id => e.id, :organ_id => xingzheng.id).tap{|x| x.set_jobs([member.id])} }

caiwu_users = [
  User.create!(name: "刘玲", phone: 13541386053, account: "liuling", password: "123456"),
  User.create!(name: "李佳", phone: 13308176710, account: "lijia", password: "123456")
  ]
  caiwu_users.each { |e| Member.create!(:user_id => e.id, :organ_id => caiwu.id).tap{|x| x.set_jobs([member.id])} }

zservice_users = [
  User.create!(name: "甘华丽", phone: 15281039267, account: "ganhuali", password: "123456"),
  User.create!(name: "周英", phone: 13438800586, account: "zhouying", password: "123456"),
  User.create!(name: "邓宇晶", phone: 18600160167, account: "dengyujing", password: "123456"),
  User.create!(name: "邹瑜", phone: 18008055031, account: "zouyu", password: "123456"),
  User.create!(name: "文靖", phone: 15199925679, account: "wenjing", password: "123456"),
  User.create!(name: "李源冰", phone: 13350081882, account: "liyuanbin", password: "123456"),
  User.create!(name: "廖肖韦", phone: 15202859971, account: "liaoxiaowei", password: "123456"),
  User.create!(name: "钟刘梅", phone: 15196634082, account: "zhongliumei", password: "123456")
 ]
 zservice_users.each { |e| Member.create!(:user_id => e.id, :organ_id => zservice.id).tap{|x| x.set_jobs([member.id])} }

# 初始化管理员
# zhiyi_admin_actor = Actor.create!(membership_id: admin.id, organ_id: zhiyi.id)
# ['xiegang', 'tangjiujun'].each do |account|
#   User.where(:account => account).each { |user| user.actors << zhiyi_admin_actor }
# end