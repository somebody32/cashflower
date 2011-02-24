require 'spec_helper'

describe CashflowsController do
  let(:user) { Factory(:user) }
  before(:each) { sign_in user }

  context "/index" do
    it "should render" do
      cashflow = Factory(:cashflow, :user => user)
      get :index

      response.should be_success
      JSON.parse(response.body).should include({ "balance" => "0.0", "cashflows" => user.cashflows.to_json })
    end
  end

  context "/create" do
    it "should render ok status if save was performed" do
      post :create, :cashflow => { :value => 0.5 }

      response.should be_success
      JSON.parse(response.body).should include({ "status" => "ok" })
    end

    it "should render error status if save was performed" do
      post :create, :cashflow => { :value => 0 }

      response.should be_success
      JSON.parse(response.body).should include({ "status" => "error" })
    end
  end
end
