# -*- coding: utf-8 -*-
module Phonebook
  require 'rack/contrib'
  class Organs < Grape::API
    use Rack::JSONP
    format :json

    get "get_root" do
      user = User.where(email: params[:email]).first
      if user
        if !user.actors.blank?
          organ_id = user.actors.first.organ_id
          organ = Organ.find(organ_id)
          organ.is_root? ? result = organ : result = organ.root
        end
      end
      return result
    end

    get "get_organ_tree" do
      if params[:organ_id]
        if organ = Organ.where(id: params[:organ_id]).first
          result = tree organ
        end
      end
      return result
    end

    helpers do
    def tree node
      nodes = node.nil? ? node.root : node.children { |x| x}
      under = {}

      if node
        return node if nodes.empty?
      end
      nodes.each do |organ|
        organ[:child]=[]
        if organ.has_children?
          organ[:child] = tree(organ)
        end
      end
      nodes
    end
  end
  end
end

