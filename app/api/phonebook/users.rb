# -*- coding: utf-8 -*-
module Phonebook
  require 'rack/contrib'
  class Users < Grape::API
    use Rack::JSONP
    format  :json

    get "/all_users" do
      root = Organ.where(id: params[:organ_id]).first
      users = root.subtree_members.order("name ASC")
      users.inject({}) do |index,user|
        user[:organname] = user.organs.first.fullname#full_name(user.organs.first)
      end
      users
    end

    def full_name organ
      if organ.parent ==nil
        return ""
      end
      return  organ.name unless organ.parent
      full_name(organ.parent) + "/" + organ.name
    end


  end
end









#    end
=begin
    def get_users
      if params[:organ_id]
        organ = Organ.where(id: params[:organ_id]).first
        actors = Actor.where(organ_id: params[:organ_id])
        result=[]
        actors.each do |actor|
          result = result + actor.users
        end
        result
      end
      return result
    end




  end
end
=end
