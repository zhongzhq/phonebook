# -*- coding: utf-8 -*-
class OrganMailer < BaseMailer
  def pass user_id
   @user = User.find_by_id user_id
   return false if @user.blank?

   @organ_apply = OrganApply.where(:user_id => @user.id).first
   @organ = @user.organs.first.root if @organ_apply.success?
   
   mail(:to => @user.email, :subject => '企业申请通过')
 end
end
