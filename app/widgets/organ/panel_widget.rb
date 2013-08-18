class Organ::PanelWidget < ApplicationWidget
  responds_to_event :show
  responds_to_event :all
  responds_to_event :add_user
  responds_to_event :add_user_submit
  responds_to_event :edit_user
  responds_to_event :edit_user_submit
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
    @members = Organ.find(params[:id]).root.subtree_members.paginate(:page => params[:page])
    replace :view => :all
  end

  # 添加组织成员
  def add_user
    @organ = Organ.find params[:id]
    @user = User.new
    replace "##{widget_id} #user-edit-dialog", {:view => :add}
  end

  def add_user_submit
    @organ = Organ.find params[:id]
    params[:user][:password] = SecureRandom.hex(8)
    @user = User.new(params[:user])
    @user.skip_confirmation!

    actors = (params[:membership_ids] || []).map do |id|
      Actor.first_or_create :organ => @organ, :membership => Membership.find(id)
    end

    if @user.save
      @user.send_reset_password_instructions
      @user.adjust @organ, actors
      render :state => :show
    else
      replace "##{widget_id} #user-edit-dialog", {:view => :add}
    end
  end

  # 修改用户信息
  def edit_user
    @organ = Organ.find params[:id]
    @user = User.find params[:user_id]
    replace "##{widget_id} #user-edit-dialog", {:view => :edit}
  end

  def edit_user_submit
    @organ = Organ.find params[:id]
    @user = User.find params[:user_id]

    actors = (params[:membership_ids] || []).map do |id|
      Actor.first_or_create :organ => @organ, :membership => Membership.find(id)
    end

    if @user.update_attributes params[:user]
      @user.adjust @organ, actors
      @members = @organ.members.paginate(:page => params[:page])
      replace :view => :show
    else
      replace "##{widget_id} #user-edit-dialog", {:view => :edit}
    end
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
