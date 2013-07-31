class Organ::SearchWidget < ApplicationWidget
  responds_to_event :search

  def display
    render
  end

  def search
    @members = current_user.organs.first.root.members_and_descendants
    .where("name LIKE :text OR phone LIKE :text OR email LIKE :text", {:text => "%#{params[:text]}%"})
    .paginate(:page => params[:page], :per_page => 5)
    replace view: :display
  end

end
