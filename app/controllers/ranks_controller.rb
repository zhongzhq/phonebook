# -*- coding: utf-8 -*-
class RanksController < ApplicationController
  def index
    @ranks = Rank.all

    if params[:callback]
      render :json=>@ranks,:callback=>params[:callback]
    end
  end

  def new
    parent = Rank.find(params[:id]) if params[:id]
    @rank = Rank.new(parent_id: parent ? parent.id : nil)
  end

  def create
    @rank = Rank.new(params[:rank])

    if @rank.save
      redirect_to ranks_path, notice: '添加成功'
    else
      render 'new'
    end
  end

  def show
    @rank = Rank.find(params[:id])
  end

  def edit
    @rank = Rank.find(params[:id])
  end

  def update
    @rank = Rank.find(params[:id])

    if @rank.update_attributes(params[:rank])
      redirect_to ranks_path, notice: '更新成功'
    else
      render 'edit'
    end
  end

  def destroy
    @rank = Rank.find(params[:id])
    @rank.destroy    
    redirect_to ranks_path, notice: '删除成功'
  end
end
