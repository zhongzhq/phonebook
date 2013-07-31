# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
  load_and_authorize_resource
  
  has_widgets do |root|
    root << widget('organ/main', :organ)
  end

  def index
    @organ = current_user.organs.first
  end

  # 申请创建一个企业
  def new
    @organ = Organ.new
  end
  
  def create
    @organ = Organ.new(params[:organ])

    if @organ.save
      # 把当前申请用户加入新创建企业的成员和管理员组
      @organ.add(current_user, Membership.find_or_create(@organ, Settings.admin))
      @organ.add(current_user, Membership.find_or_create(@organ, Settings.member))
      redirect_to root_path, notice: '申请成功，正在审核'
    else
      render 'new'
    end
  end

  # 添加下级组织
  def new_child
    @organ = Organ.find(params[:id]).children.build
  end

  def create_child
    @organ = Organ.new(params[:organ])

    return redirect_to organs_path, notice: '添加成功' if @organ.save
    render 'new_child'
  end

  # 申请加入企业
  def join
  end

  def join_create
    @organ = Organ.find(params[:id]) rescue nil

    if Apply.add(current_user, @organ)
      redirect_to root_path, notice: '组织申请成功，审核中'
    else
      redirect_to root_path, alert: '组织申请失败，你可能已申请过或者正在申请其它企业'
    end
  end
  
  # 显示待申请的成员
  def apply_members
    @organ = Organ.find(params[:id])
    render :layout => false
  end

  # 通过用户的申请
  def pass_user
    @organ = Organ.find(params[:id])
    Apply.find_by_user_and_organ(User.find(params[:user_id]), @organ).pass
    render 'apply_members', :layout => false
  end

  # 编辑组织信息
  def edit
    @organ = Organ.find(params[:id])
  end

  def update
    @organ = Organ.find(params[:id])

    return redirect_to organs_path, notice: '更新成功' if @organ.update_attributes(params[:organ])
    render 'edit'
  end

  # 向组织添加联系人
  def new_member
    @user = User.new
  end

  def create_member
    params[:user][:password] = SecureRandom.hex(8)
    @user = User.new(params[:user])

    if @user.save
      @user.adjust( Organ.find( params[:new_organ_ids] ) )
      redirect_to organs_path, :notice => '添加联系人成功'
    else
      render 'new_member'
    end
  end
end