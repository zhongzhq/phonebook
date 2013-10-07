# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  layout false

  def new
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.new
  end

  def create
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.new(params[:user])
    if @user.save
      @user.add_actor(params[:user][:membership_ids].delete_if{|x| x.blank? }, @organ)
      redirect_to organ_path(@organ, :layout => "content"), :notice => "添加用户成功"
    else
      render "new"
    end
  end

  def edit
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.find(params[:id])
  end

  def update
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to organ_path(@organ, :layout => "content"), :notice => "用户信息修改成功"
    else
      render "edit"
    end
  end
end
