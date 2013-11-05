# -*- coding: utf-8 -*-
class TreeWidget < ApplicationWidget
  responds_to_event :refresh, :with => :display
  responds_to_event :organs

  def display
    @root_organs = Organ.roots
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
