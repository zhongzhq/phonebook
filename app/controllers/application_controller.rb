class ApplicationController < ActionController::Base
  protect_from_forgery

  # 为了安全，在每个请求之后都重新设置验证码
  after_filter :reset_last_captcha_code!

  # Devise Filter
  before_filter :authenticate_user!, :except => [:activate]

  # 用户登陆后跳转
  def after_sign_in_path_for(resource)
    current_user.is_system_admin? ? master_index_path : root_path
  end

  # 设置 devise 页面 Layout
  layout :layout_by_resource

  protected
  def layout_by_resource
    devise_controller? ? 'default' : 'application'
  end
end
