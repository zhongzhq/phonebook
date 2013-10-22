# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
  def index        
  end

  def new
    if params[:id]
      @organ = Organ.find(params[:id]).children.build
    else
      @organ = Organ.new
    end
    ["房间号", "电话一", "电话二", "地址"].each {|key| @organ.organ_attrs.build(:key => key) }
  end

  def create
    organ_attrs_attributes = params[:organ].delete("organ_attrs_attributes")
    @organ = Organ.new(params[:organ])
    if @organ.save
      @organ.update_attributes(:organ_attrs_attributes => organ_attrs_attributes)
      redirect_to organ_path(@organ, :layout => "content"), :notice => "添加下级组织成功"
    else
      render "new"
    end
  end

  def show
    @organ = Organ.find(params[:id])
    @users = @organ.members
  end

  def show_with_organ
    @organ = Organ.find(params[:id])
    @users = @organ.members # if @organ.children.blank?
  end

  def edit
    @organ = Organ.find(params[:id])
    ["房间号", "电话一", "电话二", "地址"].each {|key| @organ.organ_attrs.build(:key => key) } if @organ.organ_attrs.blank?
  end

  def update
    @organ = Organ.find(params[:id])
    if @organ.update_attributes(params[:organ])
      redirect_to organ_path(@organ, :layout => "content"), :notice => "修改组织信息成功"
    else
      render "edit"
    end
  end
end