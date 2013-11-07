# -*- coding: utf-8 -*-
class CommonsController < ApplicationController
  load_and_authorize_resource

  def create
    @common.save ? redirect_to(commons_path) : render("new")
  end

  def update
    @common.update_attributes(params[:common]) ? redirect_to(commons_path) : render("edit")
  end

  def destroy
    @common.try(:destroy)
    redirect_to commons_path
  end
end
