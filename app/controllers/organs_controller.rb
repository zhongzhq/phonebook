# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
  def index        
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
      redirect_to organ_path(@organ)
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
  end

  def update
    @organ = Organ.find(params[:id])
    if @organ.update_attributes(params[:organ])
      redirect_to organ_path(@organ)
    else
      render "edit"
    end
  end
end