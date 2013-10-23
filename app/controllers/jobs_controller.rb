# -*- coding: utf-8 -*-
class JobsController < ApplicationController
  def index
    @jobs = Job.order("sort DESC")
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(params[:job])

    if @job.save
      redirect_to jobs_path
    else
      render "new"
    end
  end

  def edit
    @job = Job.find(params[:id])    
  end

  def update
    @job = Job.find(params[:id])

    if @job.update_attributes(params[:job])
      redirect_to jobs_path
    else
      render "edit"
    end
  end
end
