class DashboardController < ApplicationController  
  def index
    @user = User.where( email: current_user.email ).first
  end
end
