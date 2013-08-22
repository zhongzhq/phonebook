# -*- coding: utf-8 -*-
class OrganMailer < BaseMailer
  def pass organ_apply
    @organ_apply = OrganApply.find organ_apply
    @user = User.find @organ_apply.user_id
    return false if @organ_apply.blank? || @user.blank?

    @organ = Organ.where(:name => @organ_apply.organ_name).first if @organ_apply.success?
    mail(:to => @user.email, :subject => '企业申请通知')
 end
end
