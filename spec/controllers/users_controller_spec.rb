require 'spec/spec_helper'

describe UsersController do
  describe "GET index" do
    before (:each) do
      @user = FactoryGirl.create(:user)
      get :index
      assign(:users, @user)
      render :action => 'index'
      #assigns(:users).should eq([user])
    end
  end

  it "renders the index template" do
    get :index
    response.should render_template("index")
  end

  #describe "GET show" do
   # before (:each) do
    #  @user = Factory(:user)
     # get :show, 
end

# commit this
# use factory girl in this spec
# write specs for the other actions in this controller
# write a spec for the other controller
  