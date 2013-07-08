# -*- coding: utf-8 -*-
class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(params[:user])

    if request.post? && captcha_valid?(params[:captcha])
      super
    else
      resource.errors.add(:captcha, '验证码错误')
      render 'new'
    end
  end
end
