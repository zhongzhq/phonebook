class ApplicationWidget < Apotomo::Widget
  include Devise::Controllers::Helpers
  include CanCan::ControllerAdditions
end