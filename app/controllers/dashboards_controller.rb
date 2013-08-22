class DashboardsController < ApplicationController
  has_widgets do |root|
    root << widget('dashboard', :dashboard)
  end
end