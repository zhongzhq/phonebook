# -*- coding: utf-8 -*-
class MembershipsController < ApplicationController
  def index
    @memberships = Membership.all

    if params[:callback]
      render :json=>@memberships,:callback=>params[:callback]
    end
  end

  def new
    @membership = Membership.new
  end

  def create
    @membership = Membership.new(params[:membership])

    if @membership.save
      redirect_to memberships_path, notice: '添加成功'
    else
      render 'new'
    end
  end

  def show
    @membership = Membership.find(params[:id])
  end

  def edit
    @membership = Membership.find(params[:id])
  end

  def update
    @membership = Membership.find(params[:id])

    if @membership.update_attributes(params[:membership])
      redirect_to memberships_path, notice: '更新成功'
    else
      render 'edit'
    end
  end
end
