# -*- coding: utf-8 -*-
class CommonsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @commons = Common.all
  end

  def new
    @common = Common.new
  end

  def create
    @common = Common.new(params[:common])

    if @common.save
      redirect_to commons_path, :notice => "新建常用电话成功"
    else
      render 'new'
    end
  end

  def edit
    @common = Common.find(params[:id])
  end

  def update
    @common = Common.find(params[:id])

    if @common.update_attributes(params[:common])
      redirect_to commons_path, :notice => "更新常用电话成功"
    else
      render 'edit'
    end
  end

  def destroy
    @common = Common.find(params[:id])
    @common.try(:destroy)
    redirect_to commons_path, :notice => "删除常用电话成功"
  end
end
