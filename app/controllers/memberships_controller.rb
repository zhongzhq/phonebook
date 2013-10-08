# -*- coding: utf-8 -*-
class MembershipsController < ApplicationController
  layout false

  def index
    @memberships = Membership.all
    render :layout => params[:layout] if params[:layout].present?
  end

  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(params[:membership])

    if @membership.save
      redirect_to memberships_path(:layout => "content"), :notice => "角色新建成功"
    else
      render "new"
    end
  end

  def edit
    @membership = Membership.find(params[:id])    
  end

  def update
    @membership = Membership.find(params[:id])

    if @membership.update_attributes(params[:membership])
      redirect_to memberships_path(:layout => "content"), :notice => "角色更新成功"
    else
      render "edit"
    end
  end

  def destroy
    @membership = Membership.find(params[:id])    
    redirect_to memberships_path(:layout => "content"), (@membership.destroy ? {:notice => "角色删除成功"} : {:alert => "角色正在使用中"})
  end
end
