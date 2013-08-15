# -*- coding: utf-8 -*-
module Phonebook
  require 'rack/contrib'
  class Users < Grape::API
    use Rack::JSONP
    format  :json

    desc "获取组织根节点所有用户"
    namespace "users" do
      get "all_users" do
        root = Organ.where(id: params[:organ_id]).first
        users = root.subtree_members.order("name ASC")
        users.inject({}) do |index,user|
          user[:organname] = user.organs.first.fullname
        end
        users
      end

      desc "获取"
      get "get_users" do
        if params[:organ_id]
          organ = Organ.find(params[:organ_id])
          result = organ.members
        end
        return result
      end

      desc "获取登录用户"
      get "get_user" do
        result = User.where(email: params[:email],authentication_token: params[:token])
        return result.first
      end

    end

  end
end
