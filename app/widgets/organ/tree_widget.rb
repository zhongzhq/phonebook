class Organ::TreeWidget < ApplicationWidget
  responds_to_event :edit
  responds_to_event :edit_submit
  responds_to_event :add
  responds_to_event :add_submit

  def display
    @organ_root = current_user.organs.first.try(:root)
    render
  end

  # 编辑组织信息
  def edit
    @organ = Organ.find params[:id]
    replace "##{widget_id} #organ-dialog", {:view => :edit}
  end

  def edit_submit
    @organ = Organ.find params[:id]

    if @organ.update_attributes(params[:organ])
      replace :state => :display
    else
      replace "##{widget_id} #organ-dialog", {:view => :edit}
    end
  end

  # 添加下级组织
  def add
    @organ = Organ.find( params[:id] ).children.build
    replace "##{widget_id} #organ-dialog", {:view => :add}
  end

  def add_submit
    @organ = Organ.new params[:organ]

    if @organ.save
      replace :state => :display
    else
      replace "##{widget_id} #organ-dialog", {:view => :add}
    end
  end

end
