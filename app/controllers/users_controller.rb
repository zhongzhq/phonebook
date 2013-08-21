# -*- coding: utf-8 -*-
class UsersController < ApplicationController  
  # 修改用户信息
  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      redirect_to dashboards_path, notice: '用户资料更新成功'
    else
      render 'edit'
    end
  end

  # 发送邮箱验证邮件
  def resend_email_confirmation    
    User.send_confirmation_instructions( :email =>
      current_user.confirmed? ? current_user.unconfirmed_email : current_user.email )
    redirect_to :back, :notice => t('devise.confirmations.send_instructions')
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
