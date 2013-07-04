class DefaultController < ApplicationController
  layout "default"
  def index
    @user_html = render_to_string("users/new.slim",:locals =>{:user => User.new},:layout => false)
  end
end
