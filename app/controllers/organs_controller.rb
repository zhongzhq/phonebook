# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
  def index
    @organs = Organ.all(:order=>"rank_id asc")
    if params[:callback]
      render :json=>@organs,:callback=>params[:callback]
    end
  end

  def new
    parent = Organ.find(params[:id]) rescue nil
    @organ = Organ.new(parent_id: parent.try(:id))
  end

  def create
    @organ = Organ.new(params[:organ])

    if @organ.save
      @organ.add_member_and_admin( current_user )
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
