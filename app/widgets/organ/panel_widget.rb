class Organ::PanelWidget < ApplicationWidget
  responds_to_event :search
  responds_to_event :children

  def display
    @organ = Organ.find(params[:organ_id])
    render
  end

  def list members
    @members = members.paginate(:page => params[:page])
    render
  end

  # 通过姓名/手机号/邮箱搜索当前组织的用户
  def search
    @members = current_user.root_organ.members_and_descendants
    .where("name LIKE :text OR phone LIKE :text OR email LIKE :text", {:text => "%#{params[:text]}%"})
    
    replace "##{widget_id} #members", { state: :list }, @members
  end

  # 显示组织的子级成员
  def children evt
    @members = Organ.find(params[:organ_id]).try(:children_members)
    replace "##{widget_id} #members", { state: :list }, @members
  end
end
