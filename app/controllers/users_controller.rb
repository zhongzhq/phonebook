# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  def new
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.new
    @user.membership_ids = [Membership.find(:first, :conditions => {:name => "成员"}).id]
  end

  def create
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.new(params[:user])
    if @user.save
      @user.add_actor(params[:user][:membership_ids].delete_if{|x| x.blank? }, @organ)
      redirect_to user_path(@user, :organ_id => @organ.id), :notice => "添加用户成功"
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
  end

  def edit
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.find(params[:id])
    @user.membership_ids = @user.actors.where(:organ_id => @organ).map(&:membership).map(&:id)
  end

  def update
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      @user.add_actor(params[:user][:membership_ids].delete_if{|x| x.blank? }, @organ)
      redirect_to user_path(@user, :organ_id => @organ.id), :notice => "用户信息修改成功"
    else
      render "edit"
    end
  end

  def reset
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.find(params[:id])    
  end

  def reset_submit
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to user_path(@user, :organ_id => @organ.id), :notice => "重置密码成功"
    else
      render "reset"
    end
  end

  # 用户自己修改信息
  def password
    @user = User.find(params[:id])
  end

  def password_submit
    @user = User.find(params[:id])
    if @user.try(:authenticate, params[:user][:current_password])      
      if @user.update_attributes(params[:user])
        redirect_to root_path, :notice => "密码修改成功"
      else
        return render "password"
      end
    else
      @user.errors.add(:current_password, "当前密码错误")
      render "password"
    end
  end

  def info
    @user = User.find(params[:id])
    ["座机号", "电子邮箱"].each {|key| @user.user_attrs.build(:key => key) } if @user.user_attrs.blank?
  end

  def info_submit
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to root_path, :notice => "用户资料更新成功"
    else
      render "info"
    end
  end
end
