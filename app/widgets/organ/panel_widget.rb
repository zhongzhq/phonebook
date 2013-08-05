class Organ::PanelWidget < ApplicationWidget
  responds_to_event :remove
  responds_to_event :applies, :with => :apply_members
  responds_to_event :pass, :with => :pass_apply

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

  def apply_members evt
    @organ = Organ.find evt[:organ_id]
    @applies = UserApply.members(@organ)

    replace "##{widget_id} #members", :view => :apply_members
  end

  def pass_apply evt
    @apply = UserApply.find evt[:id]

    @organ = @apply.actor.organ
    @applies = UserApply.members(@organ)

    @apply.pass
    
    replace "##{widget_id} #members", :view => :apply_members
  end
end
