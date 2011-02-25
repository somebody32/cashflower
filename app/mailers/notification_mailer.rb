class NotificationMailer < ActionMailer::Base
  default :from => "CashFlower <cashflowerapp@gmail.com>"
  default_url_options[:host] = "cashflower.heroku.com"

  def generated_password(user)
    @password = user.password
    mail(:to => user.email, :subject => 'Hello from CashFlower')
  end
end
