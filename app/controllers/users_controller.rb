# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  def index
    @users = User.all

    if params[:callback]
      render :json=>@users,:callback=>params[:callback]
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html {render "new.slim"}
      format.js  {render "new.slim",:layout=>false}
    end
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to users_path, notice: '添加成功'
    else
      render 'new'
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
end
