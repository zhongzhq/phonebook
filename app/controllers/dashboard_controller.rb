class DashboardController < ApplicationController
  has_widgets do |root|
    root << widget('dashboard', :dashboard)
  end

  def index
  end
end
