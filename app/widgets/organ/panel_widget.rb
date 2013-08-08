class Organ::PanelWidget < ApplicationWidget
  responds_to_event :show
  responds_to_event :all
  responds_to_event :remove_from_show
  responds_to_event :remove_form_all

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

  # 删除用户的 actor
  def remove_from_show
    @organ = Organ.find params[:id]
    remove @organ, :user_id => params[:user_id], :membership_id => params[:membership_id]
    render :state => :show
  end

  def remove_form_all
    @organ = Organ.find params[:id]
    remove @organ, :user_id => params[:user_id], :membership_id => params[:membership_id]
    render :state => :all
  end

  private
  def remove organ, args = {}
    User.find(args[:user_id]).actors.delete(
      Actor.first_or_create(:organ => organ, :membership => Membership.find(args[:membership_id]))
      )
  end

end
