# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  layout 'default', :only => [:register, :create]

  def index
    @users = User.all

    if params[:callback]
      render :json=>@users,:callback=>params[:callback]
    end
  end

  def register
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if request.post? && captcha_valid?(params[:captcha]) && @user.save
      redirect_to root_path, notice: '注册成功'
    else
      @user.errors.add(:captcha, '验证码错误')
      render 'register'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to users_path, notice: '更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path    
  end
end
