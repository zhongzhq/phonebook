class ApplicationWidget < Apotomo::Widget
  include Devise::Controllers::Helpers
  include CanCan::ControllerAdditions

  helper_method :current_user
end