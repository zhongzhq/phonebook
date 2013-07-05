class DefaultController < ApplicationController
  layout "default"

  def index
    @user = User.new
  end

  def login
    if User.find_by_account( params[:user][:account] ).try( :authenticate, params[:user][:password])
      redirect_to dashboard_index_path
    else
      redirect_to 'index'
    end
  end
end
