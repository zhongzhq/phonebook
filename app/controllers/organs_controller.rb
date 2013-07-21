# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
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
      @organ.add_member(current_user)
      @organ.add_admin(current_user)
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

  # 申请加入企业，并吧当前用户作为企业成员
  def join
    redirect_to :back, alert: '已加入企业，不能同时加入多个企业' unless current_user.memberships
  end

  def join_create
    @organ = Organ.find(params[:id])

    if @organ.try(:add_member, current_user)
      redirect_to root_path, notice: '成功加入企业'
    else
      redirect_to root_path, alert: '加入企业失败, 已经加入该企业'
    end
  end

  # 显示组织信息和成员
  def show
    @organ = Organ.find(params[:id])
    render partial: 'members', :layout => false, :locals => { members: @organ.members }
  end

  # 显示组织的子级成员
  def children_members
    @organ = Organ.find(params[:id])
    render partial: 'members', :layout => false, :locals => { members: @organ.try(:children_members) }
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

end