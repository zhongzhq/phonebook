# -*- coding: utf-8 -*-
module Phonebook
  require 'rack/contrib'
  class Sessions < Grape::API
    use Rack::JSONP
    format :json

    get "/login" do
      request.env['devise.allow_params_authentication'] = true
      if user = warden.authenticate(:scope => :user)
        user.ensure_authentication_token!
        {:user => {:display_name => user.display_name, :single_access_token => user.authentication_token, :updated_at => user.updated_at, :id => user.id }}
      else
        raise_401
      end
helpers do
  def warden
    env['warden'].params[:single_access_token] = env["HTTP_X_USER_ACCESS_TOKEN"]
    env['warden']
  end

  def current_user
    @current_user ||= env["HTTP_X_USER_ACCESS_TOKEN"].nil? ? nil : User.find_by_authentication_token(env["HTTP_X_USER_ACCESS_TOKEN"])
  end

  def authenticate!
    unless current_user
      logger.debug "authenticate fail with HTTP_X_USER_ACCESS_TOKEN #{env['HTTP_X_USER_ACCESS_TOKEN']} "
      raise_401
    end
  end
end
      #      resource = User.find_for_database_authentication(:email => params[:account])
      #      if resource.valid_password?(params[:password])
      #        Devise.sign_in(:user, resource)
      #        resource.ensure_authentication_token!
      #        return {:status => "success", :auth_token => resource.authentication_token, :email=>resource.email}
      #      end
    end


  end
end

=begin
    def login
      resource = User.find_for_database_authentication(:email => params[:account])
      if resource.valid_password?(params[:password])
        sign_in(:user, resource)
        resource.ensure_authentication_token!
        return {:status => "success", :auth_token => resource.authentication_token, :email=>resource.email}
      end
    end

    def logout
      resource = User.find_for_database_authentication(:email => params[:email])
      if resource && resource.update_attribute(:authentication_token, nil)
        return {:status => 'success', :message => '退出成功'}
      end
    end

    def get_user
      result = User.where(email: params[:email],authentication_token: params[:token])
      return result.first
    end
  end
end
=end
