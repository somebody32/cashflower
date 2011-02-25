module HelperMethods

  # Mailer
  def last_email
    ActionMailer::Base.deliveries.last
  end

  def clear_deliveries
    ActionMailer::Base.deliveries = []
  end

end

RSpec.configuration.include HelperMethods
