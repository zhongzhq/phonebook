class Master::DashboardWidget < ApplicationWidget
  def todo
    @organ_applies = OrganApply.where(:state => :review).limit(3)
    render
  end

  def count
    render
  end
end