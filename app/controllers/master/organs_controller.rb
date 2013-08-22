# -*- coding: utf-8 -*-
class Master::OrgansController < Master::ApplicationController
  #authorize_resource :class => false

  def index
    @organs = Organ.roots.reject{ |organ| organ == Organ.system_organ }
  end

  def update
    @organ = Organ.find params[:id]
    @organ.send params[:state]
    redirect_to master_organs_path, notice: '操作成功'
  end    
end