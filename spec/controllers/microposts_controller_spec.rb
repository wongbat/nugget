require 'spec_helper'

describe MicropostsController do

  describe "GET index" do
    before (:each) do
      @micropost = FactoryGirl.create(:micropost)
    end
    
    it "renders the index template" do
      get :index, :user_id => @micropost.user.id
      response.should render_template("index")
    end
  end

  describe "GET show" do
    before (:each) do
      @micropost = FactoryGirl.create(:micropost)
    end

    it "renders the show view" do
      get :show, :user_id => @micropost.user.id, :id => @micropost.id
      response.should render_template("show")
    end
  end

  describe "GET new" do
    before (:each) do
      @micropost = FactoryGirl.create(:micropost)
    end

    it "renders the new view" do
      get :new, :user_id => @micropost.user.id
      response.should render_template("new")
    end
  end

  describe "POST create" do
    before(:each) do
      @user = Factory(:user)
      @micropost_attributes = FactoryGirl.attributes_for(:micropost)
    end

    context "with valid attributes" do
      it "creates a new micropost" do
        expect{
          post :create, :user_id => @user.id, :micropost => @micropost_attributes
        }.to change(Micropost,:count).by(1)
      end

      it "redirects to the new micropost" do
        micropost = FactoryGirl.attributes_for(:micropost)
        post :create, :user_id => @user.id.to_s, :micropost => @micropost_attributes
        assigns(:micropost).content.should eq(micropost[:content])
        response.should redirect_to(user_microposts_path)
      end
    end

    context "with invalid attributes" do
      before (:each) do
        @user = FactoryGirl.create(:user)
      end

      it "will not create new micropost" do
        expect{ 
          post :create, :user_id => @user.id, micropost: FactoryGirl.attributes_for(:invalid_micropost)
        }.to_not change(Micropost,:count)
      end

      it "renders the show method" do
        post :create, :user_id => @user.id, micropost: FactoryGirl.attributes_for(:invalid_micropost)
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    context "valid attributes" do
      before (:each) do
        @micropost = FactoryGirl.create(:micropost)
        put :update, :user_id => @micropost.user.id, :id => @micropost, :micropost => FactoryGirl.attributes_for(:micropost, :content => "new stuff")
      end

      it "renders the updated @micropost details" do
        assigns(:micropost).content.should eq("new stuff")
      end

      it "stores the updated @micropost attributes" do
         @micropost.reload
         @micropost.content.should eq("new stuff")
       end

      it "redirects to the updated micropost" do
        response.should redirect_to user_micropost_path
      end
    end

    context "invalid attributes" do
      before (:each) do
        @micropost = FactoryGirl.create(:micropost)
        put :update, :user_id => @micropost.user.id, id: @micropost, micropost: FactoryGirl.attributes_for(:micropost, :content => "hi"*150)
      end

      it "locates the requested @micropost" do
        assigns(:micropost).should eq(@micropost)
      end

      it "does not change attributes for @micropost" do
        @micropost.reload
        @micropost.content.should eq("hello")
      end

      it "renders the edit template" do
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before (:each) do
      @micropost = FactoryGirl.create(:micropost)
    end

    it "deletes the user" do
      expect{
        delete :destroy, :user_id => @micropost.user.id, id: @micropost
      }.to change(Micropost,:count).by(-1)
    end

    it "redirects to index" do
      delete :destroy, :user_id => @micropost.user.id, id: @micropost
      response.should redirect_to("/users/#{@micropost.user.id}/microposts")
    end
  end
end
  