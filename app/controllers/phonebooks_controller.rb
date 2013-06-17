# -*- coding: utf-8 -*-
class PhonebooksController < ApplicationController
  def index
    @phonebooks = Phonebook.all
  end

  def new
    @phonebook = Phonebook.new
  end

  def  show
    @phonebook = Phonebook.find(params[:id])
  end

  def edit
     @phonebook = Phonebook.find(params[:id])
  end
  def create
    @phonebook = Phonebook.new(params[:phonebook])
    if @phonebook.save
      flash[:message] = "发布成功"
      redirect_to :controller=>:phonebooks, :action=>:index
    else
      flash[:message] = "保存失败"
      render :action=>:index
    end

  end
  def update
    @phonebook = Phonebook.find(params[:id])
    if @phonebook.update_attributes(params[:phonebook])
      @message ="保存成功"
      redirect_to :controller => :phonebooks,:action => :index
    else
      @message ="保存失败"
      render :action => :edit
    end
  end

end
