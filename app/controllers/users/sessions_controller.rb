# -*- coding: utf-8 -*-
class Users::SessionsController < Devise::SessionsController
  # POST /resource/sign_in

  def create
    @user = User.new(params[:user])

    if request.post? && captcha_valid?(params[:captcha])
      super
    else
      @user.errors.add(:captcha, '验证码错误')
      render 'new',layout: "default"
    end
  end
end
