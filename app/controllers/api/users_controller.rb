# -*- coding: utf-8 -*-
class Api::UsersController < Api::BaseController
  respond_to :json

  def all_users
    root = Organ.where(id: params[:organ_id]).first
    users = root.members_and_descendants.order("name ASC")
    users.each
    users.inject({}) do |index,user|
      user[:organname] = full_name(root)
    end
    if !params[:callback]
      render :json=>'{"status":400,"message":"请求方式错误，请使用jsonp方式请求数据"}'
    else
      render :json=>users,:callback=>params[:callback]
    end
  end

  def get_users
    if params[:organ_id]
      organ = Organ.where(id: params[:organ_id]).first
      actors = Actor.where(organ_id: params[:organ_id])
      result=[]
      actors.each do |actor|
        result = result + actor.users
      end
      result.inject({}) do |index,user|
        user[:organname] = full_name(organ)
      end
      result
    end

    if !params[:callback]
      render :json=>'{"status":400,"message":"请求方式错误，请使用jsonp方式请求数据"}'
    else
      render :json=>result,:callback=>params[:callback]
    end
  end

  def full_name organ
    return organ.name unless organ.parent
    full_name(organ.parent) + "/" + organ.name
  end


end
