class OrganApply < ActiveRecord::Base
  attr_accessible :user_id, :organ_name

  validates :user_id, :organ_name, presence: true

  state_machine :initial => :review do
    event :pass do
      transition :review => :success
    end
  end
end
