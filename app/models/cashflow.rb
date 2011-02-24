class Cashflow < ActiveRecord::Base
  # Associations
  belongs_to :user

  # Attributes
  attr_accessible :value, :note

  # Hooks
  after_save :update_users_balance

  # Validations
  validates :value, :presence => true, :numericality => true
  validate :correct_value

  private

  def update_users_balance
    user.increment(:balance, value)
  end

  def correct_value
    errors.add(:value, "should be a non-zero number") if value.abs < 0.01
  end
end
