# -*- coding: utf-8 -*-
class FollowsController < ApplicationController

  def index
    @follow_users = []
    Follow.find_by_follower(current_user).each do |follow|
      begin
        @follow_users << User.find(follow.followed_id)
      rescue ActiveRecord::RecordNotFound; end
    end
  end

  def new
    Follow.create(:follower_id => current_user.id, :followed_id => params[:user_id])
    redirect_to root_path(:layout => "content"), :notice => "关注成功"
  end

  def destroy
    Follow.find_by_follower_and_followed(current_user, params[:user_id]).first.try(:destroy)
    redirect_to root_path(:layout => "content"), :notice => "取消关注成功"
  end
end