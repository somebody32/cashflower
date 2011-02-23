require 'spec_helper'

describe User do
  context "registration" do
    it "should send email with generated password" do
      clear_deliveries
      @user = Factory(:user)

      last_email.should_not be_nil
    end
  end
end
