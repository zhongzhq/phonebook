# -*- coding: utf-8 -*-
class Organ::TreeWidget < ApplicationWidget
  responds_to_event :edit
  responds_to_event :edit_submit
  responds_to_event :add
  responds_to_event :add_submit
  responds_to_event :delete

  def display args
    @organ_root = Organ.find( args[:id] ).root
    render
  end

  def show
    @organ_root = Organ.find( params[:id] ).root
    replace :view => :display
  end

  # 编辑组织信息
  def edit
    @organ = Organ.find params[:id]
    replace dialog, {:view => :edit}
  end

  def edit_submit
    @organ = Organ.find params[:id]

    if @organ.update_attributes(params[:organ])
      render :state => :show
    else
      replace dialog, {:view => :edit}
    end
  end

  # 添加下级组织
  def add
    @organ = Organ.find( params[:id] ).children.build
    replace dialog, {:view => :add}
  end

  def add_submit
    @organ = Organ.new params[:organ]
    params[:id] = params[:organ][:parent_id]

    if @organ.save
      render :state => :show
    else
      replace dialog, {:view => :add}
    end
  end

  # 删除组织
  def delete
    @organ = Organ.find(params[:id])    
    return render :text => "alert(\"#{@organ.name}存在下级组织\");" unless @organ.children.blank?
    return render :text => "alert(\"#{@organ.name}下成员不为空\");" unless @organ.actors.blank?
    @organ.destroy
    params[:id] = @organ.root.id
    render :state => :show
  end

  private
  def dialog
    "##{widget_id} #organ-dialog"
  end
end
