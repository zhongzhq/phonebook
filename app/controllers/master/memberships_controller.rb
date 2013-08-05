# -*- coding: utf-8 -*-
module Master
  class MembershipsController < ApplicationController
    #load_and_authorize_resource

    def index
      @memberships = Membership.all
    end

    def create
      @membership = Membership.new(params[:membership])

      return redirect_to master_memberships_path, notice: '添加成功' if @membership.save
      render 'new'
    end

    def update
      @membership = Membership.find(params[:id])

      return redirect_to master_memberships_path, notice: '更新成功' if @membership.update_attributes(params[:membership])
      render 'edit'
    end
  end
end
