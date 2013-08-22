# -*- coding: utf-8 -*-
class OrganAppliesController < ApplicationController
  def index
    @organ_applies = OrganApply.all
    render :layout => 'master'
  end

  # 申请企业
  def new
    @organ_apply = OrganApply.new
  end

  def create
    params[:organ_apply][:user_id] = current_user.id
    @organ_apply = OrganApply.new params[:organ_apply]

    if @organ_apply.save
      redirect_to dashboards_path, notice: '申请成功，正在审核...'
    else
      render 'new'
    end
  end

  def edit
    @organ_apply = OrganApply.find params[:id]
  end

  def update
    @organ_apply = OrganApply.find params[:id]

    if @organ_apply.update_attributes(params[:organ_apply])
      @organ_apply.apply
      redirect_to dashboards_path, notice: '申请信息修改成功，正在审核...'
    else
      render 'edit'
    end
  end

  def destroy
    @organ_apply = OrganApply.find params[:id]
    @organ_apply.destroy
    redirect_to dashboards_path, notice: '申请已取消'
  end


  def check
    @organ_apply = OrganApply.find(params[:id])

    if @organ_apply && @organ_apply.state_events.include?( params[:state].to_sym )
      @organ_apply.send(params[:state])
      OrganMailer.pass( @organ_apply ).deliver
    end

    redirect_to organ_applies_path    
  end
end
