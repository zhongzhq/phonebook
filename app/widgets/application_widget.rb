# -*- coding: utf-8 -*-
class ApplicationWidget < Apotomo::Widget
  include Phonebook::Controllers::Helpers
  include CanCan::ControllerAdditions
end