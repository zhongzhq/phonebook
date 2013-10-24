# -*- coding: utf-8 -*-
module ApplicationHelper
  def input form, field_name, args = {}
    form.input field_name, {:input_html => {:class => 'form-control'}}.merge(args)
  end

  def back_link path = :back
    link_to "返回", path, :class => "btn btn-danger"
  end
end
