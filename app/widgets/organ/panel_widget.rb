class Organ::PanelWidget < ApplicationWidget
  responds_to_event :show
  responds_to_event :all

  def display args
    @organ = Organ.find args[:id]
    @members = @organ.members.paginate(:page => params[:page])
    render :view => :show
  end

  # 显示组织所有成员
  def show
    @organ = Organ.find params[:id]
    @members = @organ.members.paginate(:page => params[:page])
    replace :view => :show
  end

  # 显示组织及下级所有成员
  def all
    @members = current_user.organs.first.root.subtree_members.paginate(:page => params[:page])
    replace :view => :all
  end

  # 把用户从指定组织中移除
  def remove
    @organ = Organ.find(params[:organ_id])

    User.find(params[:user_id]).actors.delete(
      Actor.first_or_create( :organ => Organ.find(params[:organ_id]),
        :membership => Membership.find(params[:membership_id]) )  
      )
    replace view: :display
  end

end
