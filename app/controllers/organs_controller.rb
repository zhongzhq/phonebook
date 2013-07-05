# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
  def index
    @organs = Organ.all

    if params[:callback]
      render :json=>@organs,:callback=>params[:callback]
    end
  end

  def new
    parent = Organ.find(params[:id]) if params[:id]
    @organ = Organ.new(parent_id: parent ? parent.id : nil)
  end

  def create
    @organ = Organ.new(params[:organ])

    if @organ.save
      redirect_to organs_path, notice: '添加成功'
    else
      render 'new'
    end
  end

  def show
    @organ = Organ.find(params[:id])
  end

  def edit
    @organ = Organ.find(params[:id])
  end

  def update
    @organ = Organ.find(params[:id])

    if @organ.update_attributes(params[:organ])
      redirect_to organs_path, notice: '更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @organ = Organ.find(params[:id])

    if @organ.destroy
      redirect_to organs_path, notice: '删除成功'
    else
      redirect_to organs_path
    end
  end
end
