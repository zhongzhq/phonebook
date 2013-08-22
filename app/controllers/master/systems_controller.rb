# -*- coding: utf-8 -*-
class Master::SystemsController < Master::ApplicationController
  #authorize_resource :class => false

  def index
    @members = Organ.system_organ.subtree_members
  end
end