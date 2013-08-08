class Organ::MainWidget < ApplicationWidget
  responds_to_event :show_organ
  responds_to_event :all
  responds_to_event :remove_membership

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

  def remove_membership
    @user = User.find(params[:user_id])

    @user.actors.delete(
      Actor.first_or_create( :organ => Organ.find(params[:organ_id]),
        :membership => Membership.find(params[:membership_id]) )  
      )

    render :state => :all
  end

end
