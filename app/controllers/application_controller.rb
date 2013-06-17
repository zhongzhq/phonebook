class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
     session[:cas_user]

  end

end
