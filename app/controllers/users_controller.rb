# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  def edit_info
    @user = current_user
  end

  def update_info
    @user = current_user

    if @user.update_attributes(params[:user])
      redirect_to root_path, notice: '用户资料更新成功'
    else
      render 'edit_info'
    end
  end
end
