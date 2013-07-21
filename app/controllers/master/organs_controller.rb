class Master::OrgansController < MasterController
  def index
    @organs = Organ.roots
  end

  def pass
    Organ.find(params[:id]).try(:pass)
    redirect_to master_organs_path
  end
end
