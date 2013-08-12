module Master
  class OrgansController < ApplicationController
    #authorize_resource :class => false

    def index
      @organ_applies = OrganApply.all
    end

    def check
      @organ_apply = OrganApply.find(params[:id])

      @organ_apply.send(params[:state])
      OrganMailer.pass( @organ_apply.user_id ).deliver if @organ_apply.success?

      redirect_to master_organs_path
    end
  end
end