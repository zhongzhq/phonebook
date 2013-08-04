# -*- coding: utf-8 -*-
class AppliesController < ApplicationController
  def new
  end

  def create
    if Apply.safe_add( :user => current_user, :organ => Organ.find(params[:apply][:organ_id]) )
      redirect_to root_path, notice: '组织申请成功，审核中'
    else
      redirect_to root_path, alert: '组织申请失败，你可能已申请过或者正在申请其它企业'
    end
  end
end
