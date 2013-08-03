# -*- coding: utf-8 -*-
class Api::OrgansController < Api::BaseController
  respond_to :json

  def get_root

    if params[:email]
      user = User.where(email: params[:email]).first
      if user
        p user.actors
        if !user.actors.blank?
          organ_id = user.actors.first.organ_id
          organ = Organ.find(organ_id)
          organ.is_root? ? result = organ : result = organ.root
        end
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
        result = tree organ
      end
    end
    if !params[:callback]
      render :json=>'{"status":400,"message":"请求方式错误，请使用jsonp方式请求数据"}'
    else
      render :json=>result,:callback=>params[:callback]
    end
  end

  def tree node
    nodes = node.nil? ? node.root : node.children { |x| x}
    under = {}

    if node
      return node if nodes.empty?
    end
    nodes.each do |organ|
      organ[:child]=[]
      if organ.has_children?
        organ[:child] = tree(organ)
      end
    end
    nodes

  end

end
