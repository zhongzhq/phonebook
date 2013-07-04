# -*- coding: utf-8 -*-
class RanksController < ApplicationController
  def index
    @ranks = Rank.all

    if params[:callback]
      render :json=>@ranks,:callback=>params[:callback]
    end
  end

  def new
    @rank = Rank.new(parent_id: Rank.find(params[:id]).id)
  end

  def new_root
    @rank = Rank.new
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

    if @rank.destroy
      redirect_to ranks_path, notice: '删除成功'
    else
      redirect_to ranks_path
    end
  end
end