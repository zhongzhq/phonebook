# -*- coding: utf-8 -*-
module Master
  class OrgansController < ApplicationController
    layout 'master'
    #authorize_resource :class => false

    def index
      @organs = Organ.roots
    end

    def update
      @organ = Organ.find params[:id]
      @organ.send params[:state]
      redirect_to master_organs_path, notice: '操作成功'
    end    
  end
end