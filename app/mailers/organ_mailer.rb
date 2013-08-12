# -*- coding: utf-8 -*-
class OrganMailer < BaseMailer
  def pass user_id
   @user = User.find_by_id user_id
   @organ = @user.organs.first.root

   return false if @user.blank? && @organ.blank?
   mail(:to => @user.email, :subject => '企业申请通过')
  end
end
