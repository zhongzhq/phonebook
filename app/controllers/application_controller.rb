class ApplicationController < ActionController::Base
  protect_from_forgery

  has_widgets do |root|
    root << widget('tree', :organ_tree)
  end

  include Phonebook::Controllers::Helpers
end
