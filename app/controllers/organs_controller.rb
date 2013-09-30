# -*- coding: utf-8 -*-
class OrgansController < ApplicationController
  #load_and_authorize_resource

  has_widgets do |root|
    root << widget('organ/panel', :organ_panel)
  end

  def index
    @root_organ = Organ.roots.first
  end

  def new
    if params[:id]
      @organ = Organ.find( params[:id] ).children.build
      p @organ
    else
      @organ = Organ.new
    end
  end

  def create
    @organ = Organ.new(params[:organ])
    if @organ.save
      OrganAttr.create(:key => '电话一', :value => params[:organ_attrs][:phone1], :organ_id => @organ.id)
      OrganAttr.create(:key => '电话二', :value => params[:organ_attrs][:phone2], :organ_id => @organ.id)
      OrganAttr.create(:key => '办公室地址', :value => params[:organ_attrs][:addr], :organ_id => @organ.id)
      redirect_to organs_path, notice: '新建组织成功'
    else
      render 'new'
    end
  end

  def edit
    @organ = Organ.find(params[:id])
  end

  def update
    @organ =  Organ.find(params[:id])
    if @organ.update_attributes(params[:organ])
      OrganAttr.create(:key => '电话一', :value => params[:organ_attrs][:phone1], :organ_id => @organ.id)
      OrganAttr.create(:key => '电话二', :value => params[:organ_attrs][:phone2], :organ_id => @organ.id)
      OrganAttr.create(:key => '办公室地址', :value => params[:organ_attrs][:addr], :organ_id => @organ.id)
      redirect_to organs_path, notice: '组织信息更新成功'
    else
      render 'edit'
    end
  end

  # 通过姓名/手机号/邮箱搜索当前组织的用户
  def search
    session[:current_root_organ].subtree_members.where("name LIKE :text OR phone LIKE :text OR email LIKE :text", {:text => "%#{params[:text]}%"}).tap do |x|
      @members = x.paginate(:page => params[:page])
      @sum = x.count
    end
  end

  # 从组织中移除用户
  def remove_member
    @organ = Organ.find(params[:id])

    User.find(params[:user_id]).actors.delete(
      Actor.first_or_create( :organ => @organ, :membership => Membership.find(params[:membership_id]) )
      )
    redirect_to search_organs_path, notice: '移除成功'
  end

  # 向组织添加联系人
  def new_member
    @user = User.where(:phone => params[:phone].blank? ? nil : params[:phone] ).first
    @user ||= User.new
  end

  def create_member
    @user = create_user params[:user]
    return render 'new_member' if @user.id.blank?

    actors = (params[:actors] || []).map do |actor|
      organ = Organ.find actor[:organ_id]

      actor[:membership_ids].map do |membership_id|
        Actor.first_or_create :organ => organ, :membership => Membership.find(membership_id)
      end
    end.flatten.uniq

    @user.adjust session[:current_root_organ].subtree, actors
    redirect_to organs_path, :notice => '添加联系人成功'
  end

  protected
  def create_user args = {}
    user = User.where(args).first
    return user unless user.blank?

    args[:password] = SecureRandom.hex(8)
    user = User.new args
    user.skip_confirmation!
    if user.save
      #user.send_reset_password_instructions
    end
    user
  end

end
