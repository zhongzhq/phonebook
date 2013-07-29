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

  # 调整用户所属组织
  def adjust
    @user = User.find(params[:id])
  end

  def adjust_post
    @user = User.find(params[:id])
    @user.adjust( Organ.find( params[:new_organ_ids] ) )
    redirect_to organs_path, notice: '调整成功'
  end
end
