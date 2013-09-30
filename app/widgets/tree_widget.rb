# -*- coding: utf-8 -*-
class TreeWidget < ApplicationWidget

  has_widgets do
    self << widget('organ', :organ)
  end

  def display
    @root_organs = Organ.roots
    render
  end
end