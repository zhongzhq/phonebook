# -*- coding: utf-8 -*-
class Api::VersionsController < Api::BaseController
  respond_to :json

  def get_config
       YAML::load(File.read(Rails.root.to_s + '/config/version.yml'))
  end

  def update
    result = get_config

    if !params[:callback]
      render :json=>'{"status":400,"message":"请求方式错误，请使用jsonp方式请求数据"}'
    else
      render :json=>result,:callback=>params[:callback]
    end
  end

end
