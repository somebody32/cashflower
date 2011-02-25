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
  end
end
