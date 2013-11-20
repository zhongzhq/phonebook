class System < ActiveRecord::Base
  attr_accessible :login_remember_days, :page_num

  validates :login_remember_days, :page_num, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }

  def self.login_remember_days
    (Date.today + first.login_remember_days).to_time
  end

  def self.page_num
    first.page_num
  end
end
