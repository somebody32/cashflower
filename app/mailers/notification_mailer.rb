class NotificationMailer < ActionMailer::Base
  default :from => "CashFlower <notify@cashflower.heroku.com>"
  default_url_options[:host] = "cashflower.heroku.com"

  def generated_password(user)
    @password = user.password
    mail(:to => user.email, :subject => 'Hello from CashFlower')
  end
end
