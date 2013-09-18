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
  User.create!(name: "苏渝", phone: 18602881279, email: "suyu@zhiyisoft.com", password: "18602881279"),
  User.find(:first, :conditions => {name: '谢刚'}),
  #User.create!(name: "谢刚", phone: 18628171676, email: "xiegang@zhiyisoft.com", password: "18628171676"),
  User.create!(name: "钟正权", phone: 13551147353, email: "zhongzhengquan@zhiyisoft.com", password: "13551147353"),
  User.create!(name: "杨峻峰", phone: 15881151751, email: "yangjunfeng@zhiyisoft.com", password: "15881151751"),
  User.create!(name: "陈健斌", phone: 15882357025, email: "chenjianbin@zhiyisoft.com", password: "15882357025"),
  User.create!(name: "杨丹", phone: 13281283611, email: "yangdan@zhiyisoft.com", password: "13281283611"),
  User.create!(name: "何源", phone: 13320963363, email: "heyuan@zhiyisoft.com", password: "13320963363"),
  User.create!(name: "黄德洲", phone: 18782902305, email: "recurlamlisp@gamil.com", password: "18782902305"),
  User.create!(name: "张涛", phone: 15202826031, email: "zhangtao@zhiyisoft.com", password: "15202826031"),
  User.create!(name: "尹常鑫", phone: 15184469287, email: "yinchangxin@zhiyisoft.com", password: "15184469287"),
  User.create!(name: "唐久军", phone: 18782943143, email: "1549907179@qq.com", password: "123456")
  ]
  behind_actor = Actor.create!(membership_id: member.id, organ_id: behind.id)
  behind_users.each { |e| e.actors << behind_actor }

testing_users = [
  User.create!(name: "唐浩", phone: 13880129915, email: "tanghao@zhiyisoft.com", password: "13880129915")
  ]
  testing_actor = Actor.create!(membership_id: member.id, organ_id: testing.id)
  testing_users.each { |e| e.actors << testing_actor }

xingzheng_users = [
  User.create!(name: "闫秋云", phone: 13808229662, email: "yanqiuyun@zhiyisoft.com", password: "13808229662")
  ]
  xingzheng_actor = Actor.create!(membership_id: member.id, organ_id: xingzheng.id)
  xingzheng_users.each { |e| e.actors << xingzheng_actor }

caiwu_users = [
  User.create!(name: "刘玲", phone: 13541386053, email: "liuling@zhiyisoft.com", password: "13541386053"),
  User.create!(name: "李佳", phone: 13308176710, email: "lijia@zhiyisoft.com", password: "13308176710")
  ]
  caiwu_actor = Actor.create!(membership_id: member.id, organ_id: caiwu.id)
  caiwu_users.each { |e| e.actors << caiwu_actor }

zservice_users = [
  User.create!(name: "甘华丽", phone: 15281039267, email: "ganhuali@zservice.cn", password: "15281039267"),
  User.create!(name: "周英", phone: 13438800586, email: "zhouying@zservice.cn", password: "13438800586"),
  User.create!(name: "邓宇晶", phone: 18600160167, email: "dengyujing@zservice.cn", password: "18600160167"),
  User.create!(name: "邹瑜", phone: 18008055031, email: "zouyu@zservice.cn", password: "18008055031"),
  User.create!(name: "文靖", phone: 15199925679, email: "wenjing@zservice.cn", password: "15199925679"),
  User.create!(name: "李源冰", phone: 13350081882, email: "liyuanbin@zservice.cn", password: "13350081882"),
  User.create!(name: "廖肖韦", phone: 15202859971, email: "liaoxiaowei@zservice.cn", password: "15202859971"),
  User.create!(name: "钟刘梅", phone: 15196634082, email: "zhongliumei@zservice.cn", password: "15196634082")
 ]
 zservice_actor = Actor.create!(membership_id: member.id, organ_id: zservice.id)
 zservice_users.each { |e| e.actors << zservice_actor }

# 激活所有账户
User.all.map { |e| e.update_attribute(:confirmation_token, nil) }
User.all.map { |e| e.update_attribute(:confirmed_at, Time.now) }

# 初始化管理员
manage_organ = Permission.find :first, :conditions => {:name => '管理所属企业'}
zhiyi_admin_actor = Actor.create!(membership_id: admin.id, organ_id: zhiyi.id)
manage_organ.actors << zhiyi_admin_actor
['苏渝', '谢刚', '唐久军', '闫秋云'].each do |name|
  User.where(:name => name).each { |e| e.actors << zhiyi_admin_actor }
end
