class TreeWidget < Apotomo::Widget

  def display
    @root_organs = Organ.roots
    render
  end

end
