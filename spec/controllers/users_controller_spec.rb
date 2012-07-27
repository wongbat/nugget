require 'spec/spec_helper'

describe UsersController do
  describe "GET index" do
    it "assigns @users" do
      user = User.create(:name => "foo bar")
      get :index
      assigns(:users).should eq([user])
    end

    it "renders the index template" do
      get :index
      response.should render_template("index")
    end
  end
end
  