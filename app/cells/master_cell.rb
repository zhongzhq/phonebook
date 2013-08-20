class MasterCell < Cell::Rails

  def count
    @organs = Organ.roots
    @users = User.all
    render
  end

end
