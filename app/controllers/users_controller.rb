# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  layout 'default', :only => [:sign_in, :create]

  def index
    @users = User.all

    if params[:callback]
      render :json=>@users,:callback=>params[:callback]
    end
  end

  def sign_in
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to root_path, notice: '注册成功'
    else
      render 'sign_in'
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
