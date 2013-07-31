class Organ::PanelWidget < ApplicationWidget
  responds_to_event :children
  responds_to_event :remove

  def display
    @organ = Organ.find(params[:organ_id])
    render
  end

  def members organ
    @organ = organ
    @members = organ.members.paginate(:page => params[:page])
    render view: :list
  end

  # 显示组织的子级成员
  def children
    @members = Organ.find(params[:organ_id]).try(:children_members)
    replace "##{widget_id} #members", { state: :list }, @members
  end

  # 把用户从指定组织中移除
  def remove
    @organ = Organ.find(params[:organ_id])
    p @organ
    User.find(params[:user_id]).actors.delete(
      Actor.find_or_create(@organ, Membership.find_or_create(@organ, Settings.member) )
      )
    replace view: :display
  end
end
