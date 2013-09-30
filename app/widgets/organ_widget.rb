# -*- coding: utf-8 -*-
class OrganWidget < ApplicationWidget
  responds_to_event :show, :with => :display
  responds_to_event :search

  def display evt
    @organ = Organ.find evt[:id]
    @members = @organ.members.paginate(:page => evt[:page]) if @organ.children.blank?
    render
  end

  def search evt
    User.where("name LIKE :text OR phone LIKE :text OR username LIKE :text", {:text => "%#{evt[:text]}%"}).tap do |x|
      @members = x.paginate(:page => evt[:page])
      @sum = x.count
    end
    replace :view => :result
  end
end