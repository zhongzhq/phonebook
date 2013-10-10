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
    @user_id = params[:user_id]
    Follow.create(:follower_id => current_user.id, :followed_id => @user_id)
  end

  def destroy
    @user_id = params[:id]
    Follow.find_by_follower_and_followed(current_user, @user_id).first.try(:destroy)
  end
end