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
  end
end