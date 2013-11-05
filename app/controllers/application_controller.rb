# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  has_widgets do |root|
    root << widget("tree", :organ_tree)
  end

  include Phonebook::Controllers::Helpers

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => "权限拒绝"
  end
end
