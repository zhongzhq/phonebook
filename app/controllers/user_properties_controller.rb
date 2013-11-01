# -*- coding: utf-8 -*-
class UserPropertiesController < ApplicationController
  def index
    @user_properies = UserProperty.all.sort
  end

  def create
    UserProperty.create(params[:user_property])
    redirect_to user_properties_path
  end

  def edit
    @user_property = UserProperty.find(params[:id])
    params[:checked] == 'true' ? @user_property.start : @user_property.close
    render :text => "属性状态已修改"
  end
end