require 'rubygems'
require 'spork'
require "email_spec"

ENV["RAILS_ENV"] ||= 'test'

Spork.prefork do
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec

    config.include Devise::TestHelpers, :type => :controller
    config.include EmailSpec::Helpers, :type => :mailer
    config.include EmailSpec::Matchers, :type => :mailer

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
end
