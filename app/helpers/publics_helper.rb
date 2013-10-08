# -*- coding: utf-8 -*-
module PublicsHelper
  def input form, field_name, args = {}
    form.input field_name, {:input_html => {:class => 'form-control'}}.merge(args)
  end
end