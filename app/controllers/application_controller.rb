class ApplicationController < ActionController::Base
  before_filter :authenticate_user!, :prepend_mobile_path

  protect_from_forgery

  private

  def prepend_mobile_path
     if request.user_agent.to_s.downcase =~ Regexp.new(Cashflower::IOS_USER_AGENTS)
       prepend_view_path(Rails.root + 'app' + 'views' + 'ios')
     end
  end
end
