# -*- coding: utf-8 -*-
module Phonebook
  require 'rack/contrib'
  class Versions < Grape::API
    use Rack::JSONP
    format :json
    get "/version" do
      result = YAML::load(File.read(Rails.root.to_s + '/config/version.yml'))
      return result["client"].last
    end
  end
end
