class DefaultController < ApplicationController
  layout "default"

  def index
    @user = User.new
  end

  def login
    @user = User.find_by_account(params[:user][:account])

    if @user && @user.password == params[:user][:password]
      redirect_to dashboard_index_path
    else
      redirect_to 'index'
    end
  end
end
