# -*- coding: utf-8 -*-
class UserMailer < ActionMailer::Base
  default from: "626758993@qq.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.confirm.subject
  #
  def confirm user
    @user = user

    mail to: @user.email, :subject => "企业通讯录 - 用户注册激活"
  end
end
