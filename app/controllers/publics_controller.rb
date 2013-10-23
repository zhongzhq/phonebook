# -*- coding: utf-8 -*-
class PublicsController < ApplicationController
  def index
    @users = Recent.users(current_user)
  end

  def login
    @user = User.new
  end

  def authenticate
    @user = User.login(params[:user])
    if @user.present?
      if params[:remember] == "true"
        cookies[:remember] = {:value => @user.generate_authentication_token, :expires => Time.now + 60 }
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
    organ, name, username = params[:value].split(" ").map do |x|
      x.downcase.split("").join("%").insert(0, "%").insert(-1, "%")
    end

    p organ, name, username

    if params[:value].present?
      @organs = Organ.joins(:members).uniq.where("name LIKE :value OR pinyin LIKE :value", {:value => "#{@value}"})

      @users = User.where("name LIKE :value OR pinyin LIKE :value", {:value => "#{@value}"})
    end

    @value = params[:value]
  end
end
