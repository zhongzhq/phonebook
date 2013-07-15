# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
  def index
    @organs = Organ.all(:order=>"rank_id asc")
    if params[:callback]
      render :json=>@organs,:callback=>params[:callback]
    end
  end

  # 创建企业，并把当前用户作为企业成员和管理员
  def new
    return redirect_to :back, alert: '已加入企业，不能申请企业' unless current_user.memberships
    parent = Organ.find(params[:id]) rescue nil
    @organ = Organ.new(parent_id: parent.try(:id))
  end
  
  def create
    return redirect_to root_path, alert: '已加入企业，不能申请企业' unless current_user.memberships
    @organ = Organ.new(params[:organ])

    if @organ.save
      @organ.add_member_and_admin( current_user )
      redirect_to organs_path, notice: '添加成功'
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

  def show
    @organ = Organ.find(params[:id])
  end

  def edit
    @organ = Organ.find(params[:id])
  end

  def update
    @organ = Organ.find(params[:id])

    if @organ.update_attributes(params[:organ])
      redirect_to organs_path, notice: '更新成功'
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