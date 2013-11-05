# -*- coding: utf-8 -*-
class UserPropertiesController < ApplicationController
  load_and_authorize_resource
  
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
    render :text => (params[:checked] == 'true' ? "<span style='color: green;'>已启用</span>" : "<span style='color: gray;'>已禁用</span>")
  end
end