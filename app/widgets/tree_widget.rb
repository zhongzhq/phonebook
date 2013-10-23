# -*- coding: utf-8 -*-
class TreeWidget < ApplicationWidget
  responds_to_event :refresh, :with => :display
  responds_to_event :get_children

  def display
    @root_organs = Organ.roots
    render
  end

  def get_children
    @result = {}
    if params[:id].present?
      Organ.find(params[:id]).children.each do |organ|
        @result[organ.id] = organ.name
      end
    else
      Organ.roots.each do |organ|
        @result[organ.id] = organ.name
      end
    end
    @result.to_json
  end

end
