# -*- coding: utf-8 -*-
class MembershipsController < ApplicationController
  load_and_authorize_resource :membership,class: 'Membership'

  def index
    @memberships = Membership.all
  end

  def create
    @membership = Membership.new(params[:membership])
    return redirect_to memberships_path, notice: '添加成功' if @membership.save
    render 'new'
  end

  def edit
    @membership = Membership.find(params[:id])
  end

  def update
    @membership = Membership.find(params[:id])

    return redirect_to memberships_path, notice: '更新成功' if @membership.update_attributes(params[:membership])
    render 'edit'
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy ? flash[:notice] = '删除成功' : flash[:alert] = '删除失败，角色正在被使用'
    redirect_to memberships_path
  end
end
