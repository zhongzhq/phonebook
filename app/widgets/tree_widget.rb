# -*- coding: utf-8 -*-
class TreeWidget < ApplicationWidget
  responds_to_event :refresh, :with => :display
  responds_to_event :organs
  responds_to_event :show

  def display
    @organ = Organ.find(params[:organ_id] || params[:id]) if(params[:id].present? or params[:organ_id].present?)

    if session[:admin]
      @organs = [current_user.admin_member.organ] if current_user.admin_member
    else
      @organs = Organ.roots
    end

    @organs = @organs || []
    render
  end

  def organs
    result = {}
    Organ.roots.each do |organ|
      result[organ.name] = children(organ)
    end
    result.to_json
  end

  private
  def children organ
    if organ.children.present?
      h = {}
      organ.children.each do |organ|
        h[organ.name] = children(organ)
      end
      h
    else
      organ.name
    end
  end

end
