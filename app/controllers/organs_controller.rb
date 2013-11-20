# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
  load_and_authorize_resource
  layout "tree", :only => [:show]

  def index
    @root_organs = Organ.roots
  end

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
      redirect_to organs_path
    else
      render "new"
    end
  end

  def show
    @organ = Organ.find(params[:id])
    load_members = @organ.members.joins{jobs}.order("jobs.sort DESC")
    @users = User.joins{members}.where{members.id.in load_members}.paginate(:per_page => System.page_num, :page => params[:page])
  end

  def edit
    @organ = Organ.find(params[:id])    
  end

  def update
    @organ = Organ.find(params[:id])
    if @organ.update_attributes(params[:organ])
      redirect_to organs_path
    else
      render "edit"
    end
  end

  def destroy
    @organ = Organ.find(params[:id])
    redirect_to organs_path, (@organ.destroy ? {:notice => "组织删除成功"} : {:alert => "组织下还有成员或下级组织"})
  end
end