# -*- coding: utf-8 -*-
class SystemsController < ApplicationController
  load_and_authorize_resource

  def update
    @system.update_attributes(params[:system]) ? redirect_to(system_path(@system)) : render("edit")
  end
end
