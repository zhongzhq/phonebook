# -*- coding: utf-8 -*-
class Api::SessionsController < Api::BaseController

  before_filter :ensure_params_exist

  def login
    resource = User.find_for_database_authentication(:email => params[:user_login][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user_login][:password])
      sign_in(:user, resource)
      resource.ensure_authentication_token!
      render :json=> {:status => "success", :auth_token => resource.authentication_token, :email=>resource.email},:callback=>params[:callback]
      return
    end
    invalid_login_attempt
  end

  def logout
    resource = User.find_for_database_authentication(:email => params[:user_login][:email])
    if resource && resource.update_attribute(:authentication_token, nil)
      render :json => {:status => 'success', :message => '退出成功'},:callback=>params[:callback]
    else
      render :json => {:status => 'failed', :message => '需要参数 email'},:callback=>params[:callback]
    end
  end

  def get_user
    result = User.where(email: params[:user_login][:email],authentication_token: params[:user_login][:token])
    if result.first
      render :json =>result.first,:callback=>params[:callback]
    else
      render :json => {:status => 'failed', :message => "请先登录"},:callback=>params[:callback]
    end

  end

  protected
  def ensure_params_exist
    return unless params[:user_login].blank?
    render :json=>{:status=>"failed", :message=>"missing user_login parameter"}, :status=>422
  end

  def invalid_login_attempt
    render :json=> {:status=>"failed", :message=>"Error with your login or password"}, :status=>401
  end
end
