# -*- coding: utf-8 -*-
class Users::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    build_resource(params[:user])

    if request.post? && captcha_valid?(params[:captcha])
      @user = User.where( email: params[:user][:email] ).first
      super
    else
      resource.errors.add(:captcha, '验证码错误')
      render 'new'
    end
  end
end
