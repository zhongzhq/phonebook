# -*- coding: utf-8 -*-

# 初始化系统设置
System.create!(Settings.system)
Settings.user.properties.each { |property| Property.create(:name => property) }

# ----------------- zhiyi init ------------------
# 部门初始化
zhiyi = Organ.create!(name: '成都知一软件有限公司' )
  software = zhiyi.children.create!(name: '软件研发部' )
    front = software.children.create!(name: '前台开发部' )
    behind = software.children.create!(name: '后台开发部' )
  testing = zhiyi.children.create!(name: '测试部' )
  xingzheng = zhiyi.children.create!(name: '行政部' )
  caiwu = zhiyi.children.create!(name: '财务部' )
  zservice = zhiyi.children.create!(name: '极服务' )

# 职务初始化
boss = Job.create!(name: '总经理', :sort => 80)
leader = Job.create!(name: '项目经理', :sort => 60)
member = Job.create!(name: '员工', :sort => 10)
engineer = Job.create!(name: '工程师', :sort => 40)

# 成员初始化
User.create!(name: "苏渝", mobile_phone: 18602881279, account: "suyu", password: "123456")
User.create!(name: "谢刚", mobile_phone: 18628171676, account: "xiegang", password: "123456")
User.create!(name: "钟正权", mobile_phone: 13551147353, account: "zhongzhengquan", password: "123456")

User.create!(name: "杨峻峰", mobile_phone: 15881151751, account: "yangjunfeng", password: "123456")
User.create!(name: "何源", mobile_phone: 13320963363, account: "heyuan", password: "123456")

behind_users = [  
  User.create!(name: "陈健斌", mobile_phone: 15882357025, account: "chenjianbin", password: "123456"),
  User.create!(name: "杨丹", mobile_phone: 13281283611, account: "yangdan", password: "123456"),  
  User.create!(name: "黄德洲", mobile_phone: 18782902305, account: "huangdezhou", password: "123456"),
  User.create!(name: "张涛", mobile_phone: 15202826031, account: "zhangtao", password: "123456"),
  User.create!(name: "尹常鑫", mobile_phone: 15184469287, account: "yinchangxin", password: "123456"),
  User.create!(name: "唐久军", mobile_phone: 18782943143, account: "tangjiujun", password: "tang")
  ]
  behind_users.each { |e| Member.first_or_create(:user_id => e.id, :organ_id => behind.id).tap{|x|
    x.set_jobs([member.id])
    } }

  ['suyu'].each do |username|
    User.where(:account => username).each { |e|
      Member.first_or_create(:user_id => e.id, :organ_id => zhiyi.id).tap{|x|
        x.set_jobs([boss.id])
        x.update_attributes(:is_admin => 1);
        } }
  end

  ['xiegang', 'zhongzhengquan'].each do |username|
    User.where(:account => username).each { |e|
      Member.first_or_create(:user_id => e.id, :organ_id => software.id).tap{|x|
        x.set_jobs([leader.id])
        x.update_attributes(:is_admin => 1);
        } }
  end

  ['heyuan', 'yangjunfeng'].each do |username|
    User.where(:account => username).each { |e|
      Member.first_or_create(:user_id => e.id, :organ_id => behind.id).tap{|x|
        x.set_jobs([engineer.id])
        } }
  end

testing_users = [
  User.create!(name: "唐浩", mobile_phone: 13880129915, account: "tanghao", password: "123456")
  ]
  testing_users.each { |e| Member.first_or_create(:user_id => e.id, :organ_id => testing.id).tap{|x|
    x.set_jobs([member.id])
    } }

xingzheng_users = [
  User.create!(name: "闫秋云", mobile_phone: 13808229662, account: "yanqiuyun", password: "123456")
  ]
  xingzheng_users.each { |e| Member.first_or_create(:user_id => e.id, :organ_id => xingzheng.id).tap{|x| x.set_jobs([member.id])} }

caiwu_users = [
  User.create!(name: "刘玲", mobile_phone: 13541386053, account: "liuling", password: "123456"),
  User.create!(name: "李佳", mobile_phone: 13308176710, account: "lijia", password: "123456")
  ]
  caiwu_users.each { |e| Member.first_or_create(:user_id => e.id, :organ_id => caiwu.id).tap{|x| x.set_jobs([member.id])} }

zservice_users = [
  User.create!(name: "甘华丽", mobile_phone: 15281039267, account: "ganhuali", password: "123456"),
  User.create!(name: "周英", mobile_phone: 13438800586, account: "zhouying", password: "123456"),
  User.create!(name: "邓宇晶", mobile_phone: 18600160167, account: "dengyujing", password: "123456"),
  User.create!(name: "邹瑜", mobile_phone: 18008055031, account: "zouyu", password: "123456"),
  User.create!(name: "文靖", mobile_phone: 15199925679, account: "wenjing", password: "123456"),
  User.create!(name: "李源冰", mobile_phone: 13350081882, account: "liyuanbin", password: "123456"),
  User.create!(name: "廖肖韦", mobile_phone: 15202859971, account: "liaoxiaowei", password: "123456"),
  User.create!(name: "钟刘梅", mobile_phone: 15196634082, account: "zhongliumei", password: "123456")
 ]
 zservice_users.each { |e| Member.first_or_create(:user_id => e.id, :organ_id => zservice.id).tap{|x|
  x.set_jobs([member.id])
  } }

User.all.each do |user|
  user.update_attributes(
    :office_phone => ["15202859971", "15199925679", "13438800586"].shuffle.first,
    :office_address => ["3-1203", '4-4123', '2-3234'].shuffle.first)
end