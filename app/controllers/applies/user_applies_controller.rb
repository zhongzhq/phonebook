# -*- coding: utf-8 -*-
module Applies
  class UserAppliesController < ApplicationController
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

    def children_organs
      hash = {}
      @organs = params[:id] ? Organ.find(params[:id]).children : Organ.roots

      @organs.map { |organ| hash[organ.id] = organ.name }

      render :json => hash
    end

    def memberships      
      hash = {}

      Membership.where(organ_id: Organ.find(params[:organ_id]).root.id)
      .map { |membership| hash[membership.id] = membership.name }

      render :json => hash
    end
  end
end