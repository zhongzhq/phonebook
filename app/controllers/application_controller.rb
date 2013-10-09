class ApplicationController < ActionController::Base
  protect_from_forgery

  has_widgets do |root|
    root << widget('tree', :organ_tree)
  end

  helper_method :current_user

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      session[:user_id] = nil
    end
  end
end
