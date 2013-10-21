# -*- coding: utf-8 -*-
module Phonebook
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      included do
        helper_method :current_user
      end

      def current_user
        begin
          @current_user ||= if session[:user_id]
            User.find(session[:user_id])
          else
            User.find_by_auth_token(request.cookies["remember"])
          end
        rescue ActiveRecord::RecordNotFound
          session[:user_id] = nil
        end
      end
      
    end
  end
end