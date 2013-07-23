# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
  load_and_authorize_resource
  
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

  # 调整用户所属组织
  def adjust
    @origin_organ = Organ.find(params[:id])
    @user = User.find(params[:user_id])    
  end

  def adjust_post
    @user = User.find(params[:organ][:user_id])
    @user.actors.delete( Actor.find_or_create( Organ.find(params[:organ][:origin_organ_id]), Membership.organ_member ) )
    @user.actors << Actor.find_or_create( Organ.find(params[:organ][:new_organ_id]), Membership.organ_member )
    redirect_to organs_path, notice: '调整成功'
  end
end