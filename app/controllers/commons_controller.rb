# -*- coding: utf-8 -*-
class CommonsController < ApplicationController
  def index
    @commons = Common.all
  end

  def new
    @common = Common.new
  end

  def create
    @common = Common.new(params[:common])

    if @common.save
    else
    end
  end

  def destroy
  end
end