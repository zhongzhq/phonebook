# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
  def index
    @organ = Organ.find(params[:id])
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

  # 指定组织下的所有成员
  def members
    @organ = Organ.find(params[:id])
    @members = @organ.try(:all_member)
    render :layout => false
  end

  # 指定组织的所有下级组织成员
  def sub_members
    @organ = Organ.find(params[:id])
    @sub_members = @organ.sub_members
    render :layout => false
  end

  def show
    @organ = Organ.find(params[:id])
    render :layout => false
  end

  def edit
    @organ = Organ.find(params[:id])
  end

  def update
    @organ = Organ.find(params[:id])

    if @organ.update_attributes(params[:organ])
      redirect_to organs_path( :id => @organ.id ), notice: '更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @organ = Organ.find(params[:id])

    if @organ.destroy
      redirect_to organs_path, notice: '删除成功'
    else
      redirect_to organs_path
    end
  end

end