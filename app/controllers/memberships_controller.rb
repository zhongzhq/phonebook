# -*- coding: utf-8 -*-
class MembershipsController < ApplicationController

    def index
      @memberships = Membership.find_by_organ session[:current_root_organ]
    end

    def new
      @membership = Membership.new
    end

    def create
      params[:membership][:organ_id] = session[:current_root_organ].id
      @membership = Membership.new(params[:membership])

      return redirect_to memberships_path, notice: '添加成功' if @membership.save
      render 'new'
    end

    def edit
      @membership = Membership.find(params[:id])
    end

    def update
      @membership = Membership.find(params[:id])

      return redirect_to memberships_path, notice: '更新成功' if @membership.update_attributes(params[:membership])
      render 'edit'
    end
    
  end