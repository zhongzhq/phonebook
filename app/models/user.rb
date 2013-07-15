class User < ActiveRecord::Base
  attr_accessor :account
  # Include default devise modules. Others available are:
  # :rememberable, :trackable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable, :recoverable, :validatable#, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :password, :name, :email, :phone, :password_confirmation, :status, :account

  validates_presence_of :username, :password, :email, :phone, :password_confirmation


  has_and_belongs_to_many :actors

  def confirm_email?
    self.confirmation_token.blank?
  end

  def activate?
    self.status == 1 ? true : false
  end

  # 允许使用 用户名 或 Email 登陆
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if account = conditions.delete(:account)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => account.downcase }]).first
    else
      where(conditions).first
    end
  end
end
