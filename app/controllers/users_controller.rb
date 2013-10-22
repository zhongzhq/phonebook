# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  def new
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.new
  end

  def create
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.new(params[:user])
    if @user.save
      member = Member.create!(:user_id => @user.id, :organ_id => @organ.id)
      member.set_jobs(params[:user][:jobs])
      redirect_to user_path(@user, :organ_id => @organ.id)
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
    @user.jobs = Member.where(:user_id => @user.id, :organ_id => @organ.id).first.jobs.map(&:id)
  end

  def update
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      Member.where(:user_id => @user.id, :organ_id => @organ.id).first.set_jobs(params[:user][:jobs])
      redirect_to user_path(@user, :organ_id => @organ.id)
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
      if @user.update_attributes(params[:user].tap{|x| x.delete("current_password")})
        redirect_to root_path
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
  end

  def info_submit
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to root_path
    else
      render "info"
    end
  end
end
