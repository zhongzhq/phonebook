class Organ::PanelWidget < ApplicationWidget
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

  # 把用户从指定组织中移除
  def remove
    @organ = Organ.find(params[:organ_id])

    User.find(params[:user_id]).actors.delete(
      Actor.first_or_create( :organ => @organ, :membership => Membership.organ_member(@organ) )
      )
    replace view: :display
  end
end
