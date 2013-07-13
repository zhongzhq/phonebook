# -*- coding: utf-8 -*-
class Api::UsersController < Api::BaseController
  respond_to :json

  def get_users

    if params[:organ_id]
      result = User.where(organ_id: params[:organ_id])
    end

    if !params[:callback]
      render :json=>'{"status":400,"message":"请求方式错误，请使用jsonp方式请求数据"}'
    else
      render :json=>result,:callback=>params[:callback]
    end
  end


end
