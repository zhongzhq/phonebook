class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :rememberable, :trackable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :account, :password, :name, :email, :phone, :membership_id, :organ_id, :password_confirmation, :status

  validates_presence_of :account, :password, :email, :phone, :password_confirmation
  
  belongs_to :membership

  def confirm cdkey_string
    self.update_attribute( :status, 1 ) if self.cdkey == cdkey_string
  end

  def confirm_email?
    self.confirmation_token.blank?
  end

  def activate?
    self.status == 1 ? true : false
  end
end
