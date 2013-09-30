# -*- coding: utf-8 -*-
class TreeWidget < ApplicationWidget
  responds_to_event :show

  def display
    @root_organs = Organ.roots
    render
  end

  def show evt
    @organ = Organ.find evt[:id]
    @members = @organ.members.paginate(:page => evt[:page]) if @organ.children.blank?
    render
  end
end