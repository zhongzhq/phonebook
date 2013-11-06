# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
  load_and_authorize_resource
  layout "organ_tree", :only => [:show]

  def index
    @organ = Organ.find(params[:id])
    @users = @organ.members.sort{|x, y| y.jobs.map(&:sort).max <=> x.jobs.map(&:sort).max }.map(&:user)
  end

  def manage
    @root_organs = Organ.roots
  end

  def new
    if params[:id]
      @organ = Organ.find(params[:id]).children.build
    else
      @organ = Organ.new
    end
  end

  def create
    @organ = Organ.new(params[:organ])

    if @organ.save
      redirect_to manage_organs_path
    else
      render "new"
    end
  end

  def show
    @organ = Organ.find(params[:id])
    @users = @organ.members.sort{|x, y| y.jobs.map(&:sort).max <=> x.jobs.map(&:sort).max }.map(&:user)
  end

  def edit
    @organ = Organ.find(params[:id])    
  end

  def update
    @organ = Organ.find(params[:id])
    if @organ.update_attributes(params[:organ])
      redirect_to manage_organs_path
    else
      render "edit"
    end
  end

  def destroy
    @organ = Organ.find(params[:id])
    redirect_to manage_organs_path, (@organ.destroy ? {:notice => "组织删除成功"} : {:alert => "组织下还有成员或下级组织"})
  end

  def search
    organ = Organ.find(params[:id])
    @value = params[:value]

    param_one, param_two = params[:value].split(" ").map do |x|
      x.downcase.split('').join("%").insert(0, "%").insert(-1, "%")
    end

    m = Member.where{organ_id.in organ.subtree.map(&:id)}

    if @value.split.size == 1
      # 用户 或 办公地址 或 电话
      @users = User.joins(:members).where{ members.id.in m }.where{ (name.like param_one) | (pinyin.like param_one) }

      # 职务
      m1 = m.joins(:jobs).where{
        (jobs.name.like param_one) | (jobs.pinyin.like param_one)
      }
      @users += User.joins(:members).where{ members.id.in m1 }
    end

    @users = @users || []
    render "result"
  end
end