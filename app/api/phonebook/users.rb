# -*- coding: utf-8 -*-
module Phonebook
  require 'rack/contrib'
  class Users < Grape::API
    use Rack::JSONP
    format  :json
    desc "获取组织根节点所有用户"
    get "/all_users" do
      root = Organ.where(id: params[:organ_id]).first
      users = root.subtree_members.order("name ASC")
      users.inject({}) do |index,user|
        user[:organname] = user.organs.first.fullname
      end
      users
    end
    desc "获取"
    get "/get_users" do
      if params[:organ_id]
        organ = Organ.where(id: params[:organ_id]).first
        actors = Actor.where(organ_id: params[:organ_id])
        result=[]
        actors.each do |actor|
          result = result + actor.users
        end
        result
      end
      return result
    end



  end
end
