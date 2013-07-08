class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  # reset captcha code after each request for security
  after_filter :reset_last_captcha_code!
  
  protect_from_forgery

  layout :layout_by_resource

  protected

  def layout_by_resource
    if devise_controller?
      "default"
    else
      "application"
    end
  end
end
