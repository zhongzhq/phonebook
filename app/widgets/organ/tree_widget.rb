class Organ::TreeWidget < ApplicationWidget

  def display
    @organ_root = current_user.organs.first.try(:root)
    render
  end

end
