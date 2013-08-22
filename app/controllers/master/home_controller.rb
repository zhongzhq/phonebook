# -*- coding: utf-8 -*-
class Master::HomeController < Master::ApplicationController
  has_widgets do |root|
    root << widget('Master/dashboard', :dashboard)
  end
end
