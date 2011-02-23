require "spec_helper"

describe NotificationMailer do

  context "generated password" do
    before(:all) do
      @user = Factory(:user)
      @email = NotificationMailer.generated_password(@user)
    end

    it "should be set to be delivered to the email passed in" do
      @email.should deliver_to(@user.email)
    end

    it "should contain the user's password in the mail body" do
      @email.should have_body_text(/#{@user.password}/)
    end
  end

end
