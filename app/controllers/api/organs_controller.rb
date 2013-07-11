# -*- coding: utf-8 -*-
class Api::OrgansController < Api::BaseController
  respond_to :json

  def get_root

    if params[:organ_id]
      if organ = Organ.where(id: params[:organ_id]).first
        organ.is_root? ? result = organ : result = organ.root
      end
    end

    if !params[:callback]
      render :json=>'{"status":400,"message":"请求方式错误，请使用jsonp方式请求数据"}'
    else
      render :json=>result,:callback=>params[:callback]
    end
  end

  def get_childs
    if params[:organ_id]
      if organ = Organ.where(id: params[:organ_id]).first
        result = organ.children.each do |value|
          value[:child] = value.has_children?
        end

      end
    end
    if !params[:callback]
      render :json=>'{"status":400,"message":"请求方式错误，请使用jsonp方式请求数据"}'
    else
      render :json=>result,:callback=>params[:callback]
    end
  end

end
