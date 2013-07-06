class User < ActiveRecord::Base
  attr_accessible :account, :password, :name, :email, :phone, :membership_id, :organ_id, :password_confirmation, :status

  validates_presence_of :account, :password, :email, :phone, :password_confirmation
  has_secure_password
  
  belongs_to :membership

  def confirm cdkey_string
    self.update_attribute( :status, 1 ) if self.cdkey == cdkey_string
  end

  def activate?
    self.status == 1 ? true : false
  end
end
