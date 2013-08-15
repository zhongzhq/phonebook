# -*- coding: utf-8 -*-
require 'rack/contrib'

class Users::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  use Rack::JSONP
  def create
    @user = User.new(params[:user])

    if request.post? && captcha_valid?(params[:captcha])
      super
    else
      @user.errors.add(:captcha, '验证码错误')
      render 'new',layout: "default"
    end
  end


  # get json
  def login
    resource = User.find_for_database_authentication(:email => params[:account])
    if resource.valid_password?(params[:password])
      sign_in(:user, resource)
      resource.ensure_authentication_token!
      render :json=> {:status => "success", :auth_token => resource.authentication_token, :email=>resource.email}
    end

  end
  # get json
  def logout
    resource = User.find_for_database_authentication(:email => params[:email])
    if resource && resource.update_attribute(:authentication_token, nil)
      render :json => {:status => 'success', :message => '退出成功'}
    else
      render :json => {:status => 'failed', :message => '退出失败 需要参数 email'}
    end
  end

end
