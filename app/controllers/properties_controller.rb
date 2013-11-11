# -*- coding: utf-8 -*-
class PropertiesController < ApplicationController
  load_and_authorize_resource
  
  def create
    Property.create!(params[:property])
    redirect_to properties_path
  end

  def edit
    @property = Property.find(params[:id])
    params[:checked] == 'true' ? @property.start : @property.close
    render :text => (params[:checked] == 'true' ? "<span style='color: green;'>已启用</span>" : "<span style='color: gray;'>已禁用</span>")
  end
end