require 'spec_helper'

describe UsersController do

  describe "GET index" do
    before :each do
      @user = FactoryGirl.create(:user)
      get :index
    end

    it "assigns @users" do
      assigns(:users).should eq([@user])
    end

    it "renders the index template" do
      response.should render_template("index")
    end
  end

  describe "GET show" do
    before (:each) do
      @user = FactoryGirl.create(:user)
    end

    it "renders the show view" do
      User.should_receive(:find).with(@user.id.to_s).and_return(@user)
      get :show, id: @user.id
      response.should render_template("show")
    end
  end

  describe "GET new" do
    it "renders the new view" do
      get :new
      response.should render_template('new')
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new user" do
        expect{
          post :create, :user => FactoryGirl.attributes_for(:user)
        }.to change(User,:count).by(1)
      end

      it "redirects to the new user" do
        user = FactoryGirl.attributes_for(:user)
        post :create, :user => user
        assigns(:user).name.should eq(user[:name])
        assigns(:user).email.should eq(user[:email])
        response.should redirect_to assigns(:user)
      end
    end

    context "with invalid attributes" do
      it "will not create new user" do
        expect{ 
          post :create, user: FactoryGirl.attributes_for(:invalid_user)
        }.to_not change(User,:count)
      end

      it "renders the new method" do
        post :create, user: FactoryGirl.attributes_for(:invalid_user)
        response.should render_template :new
      end
    end
  end

  describe "PUT update" do
    context "valid attributes" do
      before (:each) do
        @user = FactoryGirl.create(:user)
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, :name => "joe", :email => "j@gmail.com")
      end

      it "renders the updated @user details" do
        assigns(:user).name.should eq("joe")
        assigns(:user).email.should eq("j@gmail.com")
      end

      it "stores the updated @user attributes" do
        @user.reload
        @user.name.should eq("joe")
        @user.email.should eq("j@gmail.com")
      end

      it "redirects to the updated user" do
        response.should redirect_to @user
      end
    end

    context "invalid attributes" do
      before (:each) do
        @user = FactoryGirl.create(:user)
      end
      
      it "locates the requested @user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:invalid_user)
        assigns(:user).should eq(@user)
      end

      it "does not change attributes for @user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:invalid_user)
        @user.reload
        @user.name.should eq("Mog")
        @user.email.should eq("mog@hotmail.com")
      end

      it "renders the edit template" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:invalid_user)
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before (:each) do
      @user = FactoryGirl.create(:user)
    end

    it "deletes the user" do
      expect{
        delete :destroy, id: @user
      }.to change(User,:count).by(-1)
    end
    
    it "should destroy associated microposts" do
      pending
      microposts = @user.microposts
      @user.destroy
      microposts.each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end

    it "redirects to index" do
      delete :destroy, id: @user
      response.should redirect_to("/users")
    end
  end
end
  