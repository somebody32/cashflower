require 'spec_helper'

describe StaticController do

  context "/index" do
    it "should render guest page for non-logged in users" do
      get :index
      response.should render_template("guest")
    end

    it "should render normal view for others" do
      user = Factory(:user)
      sign_in user
      get :index

      response.should render_template("index")
    end

    it "should render personal layout for iphone" do
      request.env["HTTP_USER_AGENT"] = 'iphone'
      get :index

      ApplicationController.superclass.view_paths.dup.should include("app/views/ios/")
    end
  end

end
