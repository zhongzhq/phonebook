class DashboardWidget < ApplicationWidget

  def organ
    @organ_apply = OrganApply.find :first, :conditions => {:user_id => current_user.id}
    render
  end

  def person
    render
  end

  def version
    render
  end

  def todo
    render
  end

end
