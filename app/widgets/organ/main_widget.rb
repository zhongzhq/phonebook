class Organ::MainWidget < ApplicationWidget
  responds_to_event :show_organ
  responds_to_event :all

  has_widgets do
    self <<  widget('organ/tree', :organ_tree)
    self <<  widget('organ/panel', :organ_panel)
  end

  def display
    render
  end

  # 显示组织信息和成员
  def show_organ
    replace "##{widget_id} #organ_panel", {:view => :show}
  end

  # 显示当前用户组织的顶级组织的所有成员
  def all
    @members = current_user.organs.first.root.subtree_members.paginate(:page => params[:page])
    replace "##{widget_id} #organ_panel", {:view => :all}
  end

end
