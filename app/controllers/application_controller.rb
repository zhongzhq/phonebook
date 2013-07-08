class ApplicationController < ActionController::Base
  protect_from_forgery

  # 为了安全，在每个请求之后都重新设置验证码
  after_filter :reset_last_captcha_code!

  # Devise Filter
  before_filter :authenticate_user!

  # 设置 devise 页面 Layout
  layout :layout_by_resource

  protected
  def layout_by_resource
    devise_controller? ? 'default' : 'application'
  end
end
