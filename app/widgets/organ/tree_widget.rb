class Organ::TreeWidget < ApplicationWidget

  def display
    @organ_root = current_user.root_organ
    render
  end

end
