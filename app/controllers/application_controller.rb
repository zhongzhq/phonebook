# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  # 为了安全，在每个请求之后都重新设置验证码
  after_filter :reset_last_captcha_code!

  # Devise Filter
  before_filter :authenticate_user!


  # 用户登陆后跳转
  def after_sign_in_path_for(resource)
    dashboards_path
  end

  def after_sign_out_path_for(resource)
    session[:current_root_organ] = nil
    super
  end

  # CanCan::AccessDenied 异常捕获
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: '您没有该权限！'
  end

end
