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
      session[:user_id] = @user.id
      redirect_to root_path, :notice => '登陆成功'
    else
      redirect_to root_path, :alert => '账号或密码错误'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, :notice => '退出成功'
  end
  
  def search
    @result = {}
    users = User.where("name LIKE :text OR cellphone LIKE :text OR username LIKE :text", {:text => "%#{params[:text]}%"})
    organs = users.map(&:actors).flatten.uniq.map(&:organ).uniq.sort
    organs.each do |organ|
      @result[organ] = users.find_by_organ(organ)
    end
    @result
    render "result"
  end
end