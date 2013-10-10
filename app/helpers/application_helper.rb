# -*- coding: utf-8 -*-
module ApplicationHelper
  def input form, field_name, args = {}
    form.input field_name, {:input_html => {:class => 'form-control'}}.merge(args)
  end

  def organ_back_path organ
    organ.id.present? ? organ_path(organ) : (
      organ.parent_id.present? ? organ_path( Organ.find(organ.parent_id) ) : root_path
      )
  end
end
