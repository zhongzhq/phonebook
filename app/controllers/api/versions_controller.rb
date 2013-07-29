# -*- coding: utf-8 -*-
class Api::VersionsController < Api::BaseController
  respond_to :json

  def update
    result = Version.config
    if !params[:callback]
      render :json=>'{"status":400,"message":"请求方式错误，请使用jsonp方式请求数据"}'
    else
      render :json=>result["client"].last,:callback=>params[:callback]
    end
  end

end
