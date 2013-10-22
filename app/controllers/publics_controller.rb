# -*- coding: utf-8 -*-
class PublicsController < ApplicationController
  def index
    render :layout => params[:layout] if params[:layout].present?
  end

  def login
    @user = User.new
  end

  def authenticate
    @user = User.find_first_by_account(params[:user][:account])

    if @user.try(:authenticate, params[:user][:password])
      if params[:remember] == "true"
        cookies[:remember] = {:value => @user.generate_auth_token, :expires => Time.now + Setting["remember"].to_i.day }
      end

      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to root_path, :alert => '账号或密码错误'
    end
  end

  def logout
    current_user.update_attribute(:auth_token, nil)
    session.clear
    redirect_to root_path, :notice => '退出成功'
  end
  
  def search
    @users = User.where("name LIKE :text OR cellphone LIKE :text OR username LIKE :text", {:text => "%#{params[:text]}%"})
  end
end