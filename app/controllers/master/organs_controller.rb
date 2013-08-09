module Master
  class OrgansController < ApplicationController
    #authorize_resource :class => false

    def index
      @organ_applies = OrganApply.all
    end

    def pass
      OrganApply.find(params[:id]).try(:pass)
      redirect_to master_organs_path
    end
  end
end