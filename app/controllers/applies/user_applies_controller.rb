# -*- coding: utf-8 -*-
module Applies
  class UserAppliesController < ApplicationController

    def index
      @organ = Organ.find params[:organ_id]
      @applies = UserApply.members(@organ.subtree)
    end

    def new
    end

    def create
      if UserApply.safe_add(:user => current_user,
        :organ => Organ.find( params[:apply][:organ_id] ),
        :membership => Membership.find( params[:apply][:membership_id] ) )

        redirect_to root_path, notice: '组织申请成功，审核中'
      else
        redirect_to root_path, alert: '组织申请失败，你可能已申请过或者正在申请其它企业'
      end
    end

    def update
      @apply = UserApply.find params[:id]
      @apply.pass
      redirect_to applies_user_applies_path(:organ_id => @apply.actor.organ.root), notice: '成功通过组织申请'
    end

    def children_organs
      hash = {}
      @organs = params[:id] ? Organ.find(params[:id]).children : Organ.roots
      @organs.map { |organ| hash[organ.id] = organ.name }
      render :json => hash
    end

    def memberships      
      hash = {}
      Membership.find_by_organ(Organ.find(params[:organ_id])).map { |m| hash[m.id] = m.name }
      render :json => hash
    end
  end
end