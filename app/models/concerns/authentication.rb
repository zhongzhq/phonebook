# -*- coding: utf-8 -*-
require 'securerandom'

module Concerns
  module Authentication
    extend ActiveSupport::Concern
    included do
      attr_accessible :authentication_token, :password, :password_confirmation
      has_secure_password

      def generate_authentication_token
        update_attribute(:authentication_token, SecureRandom.hex)
        self.authentication_token
      end
    end

    module ClassMethods
      def login args = {}
        find(:first, :conditions => {:account => args.stringify_keys["account"]})
        .try(:authenticate, args.stringify_keys["password"])
      end

      def find_by_authentication_token authentication_token
        find(:first, :conditions => {:authentication_token => authentication_token}) if authentication_token.present?
      end
    end
  end
end
