require 'spec_helper'

describe Cashflow do
  context "value" do
    let(:flow) { Cashflow.new }

    it "should allow value be > 0.01" do
      flow.value = 0.01
      flow.should be_valid
    end

    it "should allow value be < -0.01" do
      flow.value = -0.01
      flow.should be_valid
    end

    it "should not allow value be < abs(0.01)" do
      flow.value = 0
      flow.should_not be_valid
    end
  end

  context "user's balance" do
    let(:flow) { Factory(:user).cashflows.new }

    it "should increment user's balance" do
      flow.value = 5
      flow.save

      flow.user.balance.should eql(5)
    end

    it "should decrement user's balance" do
      flow.value = -5
      flow.save

      flow.user.balance.should eql(-5)
    end
  end
end
