# -*- coding: utf-8 -*-
module Applies
  class OrganAppliesController < ApplicationController
    def new
      @organ_apply = OrganApply.new
    end

    def create
      params[:organ_apply][:user_id] = current_user.id

      @organ_apply = OrganApply.new params[:organ_apply]

      if @organ_apply.save
        redirect_to root_path, notice: '申请成功，正在审核...'
      else
        render 'new'
      end
    end

    def init
      @organ_apply = OrganApply.find(params[:id])
    end

    def init_create
      @organ_apply = OrganApply.find(params[:id])

      @organ = Organ.create(:name => @organ_apply.organ_name)

      @membership = Membership.create(:name => params[:membership][:name], :organ_id => @organ.id)

      @actor = Actor.first_or_create(:organ => @organ, :membership => @membership)
      
      @actor.users << current_user
      Permission.where(:code => 'master_organ').first.actors << @actor

      redirect_to root_path, :notice => '企业信息初始化成功'
    end

  end
end