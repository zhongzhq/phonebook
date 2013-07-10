# -*- coding: utf-8 -*-
class Users::PasswordsController < Devise::PasswordsController
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)

    if !User.where(:account => params[:user][:account]).blank?
      super
    else
      resource.errors.add(:account, '不存在')
      render 'new'
    end
  end
end
