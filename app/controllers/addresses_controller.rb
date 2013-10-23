# -*- coding: utf-8 -*-
class AddressesController < ApplicationController
  def index
    @addresses = Address.all
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(params[:address])

    if @address.save
      redirect_to addresses_path
    else
      render "new"
    end
  end

  def edit
    @address = Address.find(params[:id])    
  end

  def update
    @address = Address.find(params[:id])

    if @address.update_attributes(params[:address])
      redirect_to addresses_path
    else
      render "edit"
    end
  end
end
