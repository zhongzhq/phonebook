# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  # welcome
  def welcome
    @user = current_user
  end

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
    @user.update_attributes(params[:user])

    actors = (params[:memberships] || []).map do |organ_name, membership_ids|
      organ = Organ.find organ_name.split("_").last
      membership_ids.map do |membership_id|
        Actor.first_or_create :organ => organ, :membership => Membership.find(membership_id)
      end
    end.flatten
    
    @user.adjust session[:current_root_organ].subtree, actors
    redirect_to organs_path, notice: '调整成功'
  end

end
