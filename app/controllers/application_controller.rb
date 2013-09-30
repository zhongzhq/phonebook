# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  # Devise Filter
  before_filter :authenticate_user!

  has_widgets do |root|
    root << widget('tree', :organ_tree)
  end

  # CanCan::AccessDenied 异常捕获
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: '您没有该权限！'
  end

end
