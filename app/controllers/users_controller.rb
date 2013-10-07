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
end