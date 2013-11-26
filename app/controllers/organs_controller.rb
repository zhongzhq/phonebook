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
    if Settings.order_by_job
      @members = load_members = @organ.members.joins{jobs}.order("jobs.sort DESC").paginate(:per_page => System.page_num, :page => params[:page])
      @users = User.joins{members}.where{members.id.in load_members}
      .sort{|x, y| y.members.map{|e| e.jobs.map(&:sort).max }.max <=> x.members.map{|e| e.jobs.map(&:sort).max}.max }
    else
      organ = @organ
      @users = User.joins{members.organ}.where{members.organ.id == organ}.order("sort DESC").paginate(:per_page => System.page_num, :page => params[:page])     
    end
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