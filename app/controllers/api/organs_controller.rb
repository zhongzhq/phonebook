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

  def get_organ_tree
    if params[:organ_id]
      if organ = Organ.where(id: params[:organ_id]).first
        result = get_childs organ.root
      end
    end
    if !params[:callback]
      render :json=>'{"status":400,"message":"请求方式错误，请使用jsonp方式请求数据"}'
    else
      render :json=>result,:callback=>params[:callback]
    end
  end

  def get_childs organ
    node = []
    unless  organ.is_root?
          node << organ
    end
    if organ.has_children?
      organ.children.each do |x|
        node << x
        get_childs x
      end
    end
    node
  end

end
