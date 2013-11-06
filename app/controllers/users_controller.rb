# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  load_and_authorize_resource
  layout "organ_tree", :only => [:new, :create, :with_organ, :reset, :edit, :update]
  
  def new
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.new
  end

  def create
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.new(params[:user])
    if @user.save
      member = Member.create!(:user_id => @user.id, :organ_id => @organ.id)
      member.set_jobs(params[:user][:jobs])
      member.update_attributes(:is_admin => params[:is_admin])

      @organ = Organ.where(:name => params[:user_organ]).first
      @user.members.first.update_attributes(:organ_id => @organ.id)

      @user.update_properties(params[:user_properties])
      redirect_to with_organ_user_path(@user, :organ_id => @organ.id)
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    Recent.create(:user_id => current_user.id, :recently_id => @user.id)
  end

  def with_organ
    @user = User.find(params[:id])
    Recent.create(:user_id => current_user.id, :recently_id => @user.id)
    @organ = Organ.find(params[:organ_id])
  end

  def with_organ_show
    @user = User.find(params[:id])
    Recent.create(:user_id => current_user.id, :recently_id => @user.id)
    @organ = Organ.find(params[:organ_id])
  end

  def edit
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.find(params[:id])

    @user.jobs = Member.where(:user_id => @user.id, :organ_id => @organ.id).first.jobs.map(&:id)
  end

  def update
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      member = Member.where(:user_id => @user.id, :organ_id => @organ.id).first
      member.set_jobs(params[:user][:jobs])
      member.update_attributes(:is_admin => params[:is_admin])
      
      @organ = Organ.where(:name => params[:user_organ]).first
      @user.members.first.update_attributes(:organ_id => @organ.id)

      @user.update_properties(params[:user_properties])
      redirect_to with_organ_user_path(@user, :organ_id => @organ.id)
    else
      render "edit"
    end
  end

  def reset
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.find(params[:id])    
  end

  def reset_submit
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to with_organ_user_path(@user, :organ_id => @organ.id)
    else
      render "reset"
    end
    p @user.errors
  end

  # 用户自己修改信息
  def password
    @user = User.find(params[:id])
  end

  def password_submit
    @user = User.find(params[:id])
    if @user.try(:authenticate, params[:user][:current_password])      
      if @user.update_attributes(params[:user].tap{|x| x.delete("current_password")})
        redirect_to root_path
      else
        return render "password"
      end
    else
      @user.errors.add(:current_password, "当前密码错误")
      render "password"
    end
  end

  def info
    @user = User.find(params[:id])
  end

  def info_submit
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to root_path
    else
      render "info"
    end
  end

  def destroy    
    @user = User.find(params[:id])

    if params[:organ_id].present?
      @organ = Organ.find(params[:organ_id])
      redirect_to organ_path(@organ), (Member.where(:user_id => @user.id, :organ_id => @organ.id).first.try(:destroy) ? {:notice => "用户从组织中删除成功"} : {:alert => "用户从组织中删除失败"})
    else
      @user.destroy
      redirect_to :back, (@job.destroy ? {:notice => "用户删除成功"} : {:alert => "用户还存在于组织下"})
    end    
  end
end
