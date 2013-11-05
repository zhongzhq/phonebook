# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
  load_and_authorize_resource
  layout "organ_tree", :only => [:show]

  def index
    @organ = Organ.find(params[:id])
    @users = @organ.members.sort{|x, y| y.jobs.map(&:sort).max <=> x.jobs.map(&:sort).max }.map(&:user)
  end

  def manage
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
      redirect_to manage_organs_path
    else
      render "new"
    end
  end

  def show
    @organ = Organ.find(params[:id])
    @users = @organ.members.sort{|x, y| y.jobs.map(&:sort).max <=> x.jobs.map(&:sort).max }.map(&:user)
  end

  def edit
    @organ = Organ.find(params[:id])    
  end

  def update
    @organ = Organ.find(params[:id])
    if @organ.update_attributes(params[:organ])
      redirect_to manage_organs_path
    else
      render "edit"
    end
  end

  def destroy
    @organ = Organ.find(params[:id])
    redirect_to manage_organs_path, (@organ.destroy ? {:notice => "组织删除成功"} : {:alert => "组织下还有成员或下级组织"})
  end

  def search
    @organ = Organ.find(params[:id])
  end
end