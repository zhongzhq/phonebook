# -*- coding: utf-8 -*-
class Master::MembershipsController < MasterController
  def index
    @memberships = Membership.all
  end

  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(params[:membership])

    return redirect_to master_memberships_path, notice: '添加成功' if @membership.save
    render 'new'
  end

  def edit
    @membership = Membership.find(params[:id])
  end

  def update
    @membership = Membership.find(params[:id])

    return redirect_to master_memberships_path, notice: '更新成功' if @membership.update_attributes(params[:membership])
    render 'edit'
  end
end
