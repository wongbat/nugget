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
      @user = FactoryGirl.create(:user)
    end

    it "renders the new view" do
      get :new, :user_id => @user.id
      response.should render_template("new")
    end
  end

  describe "POST create" do
    before (:each) do
      @user = FactoryGirl.create(:user)
      @mp_attributes = FactoryGirl.attributes_for(:micropost)
      @invalid_mp_attributes = FactoryGirl.attributes_for(:invalid_micropost)
    end

    context "with valid attributes" do
      it "creates a new micropost" do
        expect{
          post :create, :user_id => @user.id, :micropost => @mp_attributes
        }.to change(Micropost,:count).by(1)
        Micropost.last.user.id.should == @user.id
      end

      it "redirects to the index" do
        post :create, :user_id => @user.id.to_s, :micropost => @mp_attributes
        assigns(:micropost).content.should eq(@mp_attributes[:content])
        Micropost.last.user.id.should == @user.id
        response.should redirect_to(user_microposts_path(@user))
      end
    end

    context "with invalid content" do
      it "will not create new micropost" do
        expect{ 
          post :create, :user_id => @user.id, :micropost => @invalid_mp_attributes
        }.to_not change(Micropost,:count)
        Micropost.last.should == nil
      end

      it "renders the new method" do
        post :create, :user_id => @user.id, :micropost => @invalid_mp_attributes
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
         @micropost.reload.content.should eq("new stuff")
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
        delete :destroy, :user_id => @micropost.user.id, :id => @micropost
      }.to change(Micropost,:count).by(-1)
    end

    it "redirects to index" do
      delete :destroy, :user_id => @micropost.user.id, :id => @micropost
      response.should redirect_to("/users/#{@micropost.user.id}/microposts")
    end
  end
end
  