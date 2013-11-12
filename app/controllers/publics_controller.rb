# -*- coding: utf-8 -*-
class PublicsController < ApplicationController
  def index
    @organs = Organ.roots
  end

  def login
    @user = User.new
  end

  def authenticate
    @user = User.login(params[:user])
    if @user.present?
      if params[:remember] == "true"
        cookies[:remember] = {:value => @user.generate_authentication_token, :expires => Setting.login_remember_day.to_time }
      end

      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to root_path, :alert => '账号或密码错误'
    end
  end

  def logout
    current_user.update_attribute(:authentication_token, nil)
    session.clear
    redirect_to root_path, :notice => '退出成功'
  end
  
  def search
    @value = params[:value]
    @organs = SearchEngine.search_organs(@value)
    @users = SearchEngine.search_users(@value)

    if(@organs.size == 1) and (@users.blank?)
      @organ = @organs.first
      @value = @organ.fullname
      return render "result_organ"
    elsif (@organs.blank?) and (@users.size == 1)
      @user = @users.first
      return render "result_user"
    else
      return render "result"
    end
  end
end
