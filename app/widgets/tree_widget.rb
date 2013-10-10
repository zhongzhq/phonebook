class TreeWidget < ApplicationWidget
  responds_to_event :refresh, :with => :display

  def display
    @root_organs = Organ.roots
    render
  end

end
