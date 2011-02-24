class Cashflow < ActiveRecord::Base
  # Associations
  belongs_to :user

  # Attributes
  attr_accessible :value, :note

  # Hooks
  before_save :update_users_balance

  # Validations
  validates :value, :presence => true, :numericality => true
  validate :correct_value

  private

  def update_users_balance
    new_balance = user.balance + value.to_f
    user.update_attribute(:balance, new_balance) #strange, but user.increment isn't working
  end

  def correct_value
    errors.add(:value, "should be a non-zero number") if value.abs < 0.01
  end
end
