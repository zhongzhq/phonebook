class UsersController < ApplicationController
  def index

  end

  def new
    @user = User.new
    respond_to do |format|
      format.html {render "new.slim"}
      format.js  {render "new.slim",:layout=>false}
    end
  end
end
