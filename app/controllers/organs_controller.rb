# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
  #load_and_authorize_resource

  has_widgets do |root|
    root << widget('organ/panel', :organ_panel)
    root << widget('organ/tree', :organ_tree)
  end

  def index
  end

  # 申请创建一个企业
  def create
    @organ = Organ.new(params[:organ])

    if @organ.save
      redirect_to root_path, notice: '申请成功，正在审核'
    else
      render 'new'
    end
  end

  # 通过姓名/手机号/邮箱搜索当前组织的用户
  def search
    @members = current_user.organs.first.root.subtree_members
    .where("name LIKE :text OR phone LIKE :text OR email LIKE :text", {:text => "%#{params[:text]}%"})
    .paginate(:page => params[:page])
  end

  # 从组织中移除用户
  def remove_member
    @organ = Organ.find(params[:id])

    User.find(params[:user_id]).actors.delete(
      Actor.first_or_create( :organ => @organ, :membership => Membership.find(params[:membership_id]) )
      )
    redirect_to search_organs_path, notice: '移除成功'
  end

  # 向组织添加联系人
  def new_member
    @user = User.new
  end

  def create_member
    params[:user][:password] = SecureRandom.hex(8)
    @user = User.new(params[:user])

    actors = (params[:memberships] || []).map do |organ_name, membership_ids|
      organ = Organ.find organ_name.split("_").last
      membership_ids.map do |membership_id|
        Actor.first_or_create :organ => organ, :membership => Membership.find(membership_id)
      end
    end.flatten

    if @user.save
      @user.adjust( actors )
      redirect_to organs_path, :notice => '添加联系人成功'
    else
      render 'new_member'
    end
  end

end
