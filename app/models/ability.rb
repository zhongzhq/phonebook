class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # alias action form organ
    alias_action :create, :join, :join_create, :render_event_response, :to => :apply
    
    user.permissions.each do |permission|
      eval permission.code
    end

    can :apply, Organ
  end
end
