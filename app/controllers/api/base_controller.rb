class Api::BaseController < ActionController::Base
#  before_filter :authenticate_user!, :except => [:login]
  respond_to :json


end
