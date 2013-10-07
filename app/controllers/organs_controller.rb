# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
  layout false

  def new
    if params[:id]
      @organ = Organ.find(params[:id]).children.build
    else
      @organ = Organ.new
    end
  end

  def create
    @organ = Organ.new(params[:organ])
    if @organ.save
      redirect_to root_path(:layout => "content"), :notice => "添加下级组织成功"
    else
      render "new"
    end
  end

  def show
    @organ = Organ.find(params[:id])
    @members = @organ.members # if @organ.children.blank?
  end

  def edit
    @organ = Organ.find(params[:id])
  end

  def update
    @organ = Organ.find(params[:id])
    if @organ.update_attributes(params[:organ])
      redirect_to root_path(:layout => "content"), :notice => "修改组织信息成功"
    else
      render "edit"
    end
  end
end