class Setting < ActiveRecord::Base
  attr_accessible :comment, :key, :value

  def self.login_remember_day
    Date.today + where(:key => "login_remember_day").first.value.to_i
  end
end
