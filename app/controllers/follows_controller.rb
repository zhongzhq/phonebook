# -*- coding: utf-8 -*-
class FollowsController < ApplicationController
  def index
    @users = Follow.users(current_user)
  end

  def new
    Follow.create(:follower_id => current_user.id, :followed_id => params[:user_id])
    redirect_to :back
  end

  def destroy
    Follow.find_by_follower_and_followed(current_user, params[:id]).first.try(:destroy)
    redirect_to follows_path
  end
end