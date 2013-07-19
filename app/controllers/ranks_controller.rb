# -*- coding: utf-8 -*-
class RanksController < ApplicationController
  def index
    @ranks = Rank.roots
  end

  def new
    @rank = Rank.new
  end

  def create
    @rank = Rank.new(params[:rank])

    return redirect_to ranks_path, notice: '添加成功' if @rank.save
    render 'new'
  end

  def edit
    @rank = Rank.find(params[:id])
  end

  def update
    @rank = Rank.find(params[:id])

    return redirect_to ranks_path, notice: '更新成功' if @rank.update_attributes(params[:rank])
    render 'edit'
  end

  # 添加下级等级
  def new_child
    @rank = Rank.find(params[:id]).children.build
  end

  def create_child
    @rank = Rank.new(params[:rank])

    return redirect_to ranks_path, notice: '添加成功' if @rank.save
    render 'new_child'
  end
end
