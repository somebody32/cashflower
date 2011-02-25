require 'spec_helper'

describe RegistrationsController do

  before :each do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  context "/create" do
    it "should generate password for user" do
      post :create, :user => { :email => "test@tes.com" }
      controller.params[:user][:password].should_not be_nil

      response.should be_redirect
    end
  end

end

