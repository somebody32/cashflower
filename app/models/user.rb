class User < ActiveRecord::Base
  # Associations
  has_many :cashflows

  # Attributes
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Behaviour
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Hooks
  after_create :send_password_mail

  private

  def send_password_mail
    NotificationMailer.generated_password(self).deliver
  end
end
