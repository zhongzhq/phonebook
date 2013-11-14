class System < ActiveRecord::Base
  attr_accessible :login_remember_days

  validates :login_remember_days, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }

  def self.login_remember_days
    (Date.today + first.login_remember_days).to_time
  end
end
