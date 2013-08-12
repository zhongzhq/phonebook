module Master
  class OrgansController < ApplicationController
    #authorize_resource :class => false

    def index
      @organ_applies = OrganApply.all
    end

    def check
      OrganApply.find(params[:id]).send(params[:state])
      redirect_to master_organs_path
    end
  end
end