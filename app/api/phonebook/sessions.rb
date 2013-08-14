# -*- coding: utf-8 -*-
module Phonebook
  require 'rack/contrib'
  class Sessions < Grape::API
    use Rack::JSONP
    format :json

    desc "登录系统"
    get "login" do
 #     resource = User.find_for_database_authentication(:email => params[:account])
 #     if resource.valid_password?(params[:password])
 #       sign_in(:user, resource)
 #       resource.ensure_authentication_token!
 #       return {:status => "success", :auth_token => resource.authentication_token, :email=>resource.email}
 #     end
    end

    desc "退出系统"
    get "logout" do
#      resource = User.find_for_database_authentication(:email => params[:email])
#      if resource && resource.update_attribute(:authentication_token, nil)
        return {:status => 'success', :message => '退出成功'}
#      end
    end


    desc "获取登录用户"
    get "get_user" do
      result = User.where(email: params[:email],authentication_token: params[:token])
      return result.first
    end

  end
end
