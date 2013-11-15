# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  load_and_authorize_resource
  layout "tree", :except => [:change, :data_submit, :password_submit]
  
  def new
    @organ = Organ.find(params[:organ_id])
    @user = User.new
  end

  def create
    @organ = Organ.find(params[:organ_id])
    @user = User.new(params[:user])

    if params[:user][:jobs].delete_if{|x| x.blank?}.blank?
      @user.errors.add(:jobs, "角色不能为空")
      return render "new"
    end

    if @user.save
      @user.update_properties(params[:user_properties])

      member = Member.first_or_create(@user.id, @organ.id)
      member.set_jobs(params[:user][:jobs])
      member.update_attributes(:is_admin => params[:is_admin])
      
      redirect_to user_path(@user, :organ_id => @organ.id)
    else
      render "new"
    end
  end

  def show
    @organ = Organ.find(params[:organ_id]) if params[:organ_id].present?
    @user = User.find(params[:id])
  end

  def edit
    @organ = Organ.find(params[:organ_id])
    @user = User.find(params[:id])

    @user.jobs = Member.where(:user_id => @user.id, :organ_id => @organ.id).first.jobs.map(&:id)
  end

  def update
    @organ = Organ.find(params[:organ_id])
    @user = User.find(params[:id])
    
    if params[:user][:jobs].delete_if{|x| x.blank?}.blank?
      @user.errors.add(:jobs, "角色不能为空")
      return render "edit"
    end

    if @user.update_attributes(params[:user])
      @user.update_properties(params[:user_properties])

      member = Member.find_by_user_and_organ(@user.id, @organ.id)
      member.set_jobs(params[:user][:jobs])
      member.update_attributes(:is_admin => params[:is_admin])
      
      @organ = Organ.where(:name => params[:user_organ]).first
      member.update_attributes(:organ_id => @organ.id)

      redirect_to user_path(@user, :organ_id => @organ.id)
    else
      render "edit"
    end
  end

  def destroy    
    @user = User.find(params[:id])

    if params[:organ_id].present?
      @organ = Organ.find(params[:organ_id])
      redirect_to organ_path(@organ), (Member.find_by_user_and_organ(@user, @organ).destroy ? {:notice => "用户从组织中删除成功"} : {:alert => "用户从组织中删除失败"})
      @user.destroy
    else      
      redirect_to :back, (@user.destroy ? {:notice => "用户删除成功"} : {:alert => "用户还存在于组织下"})
    end    
  end

  def reset
    @organ = Organ.find(params[:organ_id])
    @user = User.find(params[:id])    
  end

  def reset_submit
    @organ = Organ.find(params[:organ_id])
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to user_path(@user, :organ_id => @organ.id)
    else
      render "reset"
    end
  end

  # 用户自己修改信息
  def change
    @user = User.find(params[:id])
  end

  def data_submit
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to root_path
    else
      render "change"
    end
  end

  def password_submit
    @user = User.find(params[:id])

    if not @user.try(:authenticate, params[:user][:current_password])
      @user.errors.add(:current_password, "当前密码错误")
      return render "change"
    end

    if @user.update_attributes(params[:user].tap{|x| x.delete("current_password")})
      redirect_to root_path
    else
      render "change"
    end
  end

end
