# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  # 为了安全，在每个请求之后都重新设置验证码
  after_filter :reset_last_captcha_code!

  # Devise Filter
  before_filter :authenticate_user!, :init_app

  def init_app
    # 切换 组织
    session[:current_root_organ] ||= (current_user || User.new).root_organs.first
  end

  # 用户登陆后跳转
  def after_sign_in_path_for(resource)
    if current_user.organs.include?(Organ.system_organ)
      session[:current_root_organ] = Organ.system_organ
      master_root_path
    else
      dashboards_path
    end
  end

  # CanCan::AccessDenied 异常捕获
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: '您没有该权限！'
  end

  # 设置 devise 页面 Layout
  layout :layout_by_resource

  protected
  def layout_by_resource
    devise_controller? ? 'default' : 'application'
  end
end
