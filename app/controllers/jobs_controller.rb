# -*- coding: utf-8 -*-
class JobsController < ApplicationController
  load_and_authorize_resource
  
  def create
    @job.save ? redirect_to(jobs_path) : render("new")
  end

  def update
    @job.update_attributes(params[:job]) ? redirect_to(jobs_path) : render("edit")
  end

  def destroy
    redirect_to jobs_path, (@job.destroy ? {:notice => "职务删除成功"} : {:alert => "职务正在使用中"})
  end
end
