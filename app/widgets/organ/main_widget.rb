class Organ::MainWidget < ApplicationWidget
  responds_to_event :show_organ
  responds_to_event :remove_membership

  def remove_membership
    @user = User.find(params[:user_id])

    @user.actors.delete(
      Actor.first_or_create( :organ => Organ.find(params[:organ_id]),
        :membership => Membership.find(params[:membership_id]) )  
      )

    render :state => :all
  end

end
