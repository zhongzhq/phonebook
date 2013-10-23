# -*- coding: utf-8 -*-
class SettingsController < ApplicationController
  def index
    @settings = Setting.all
  end

  def edit
    @setting = Setting.find(params[:id])
  end

  def update
    @setting = Setting.find(params[:id])
    @setting.update_attributes(params[:setting])
    redirect_to settings_path
  end
end
