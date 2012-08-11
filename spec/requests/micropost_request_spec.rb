require 'spec_helper'

describe 'Microposts' do
  before :each do
    @micropost = FactoryGirl.create(:micropost)
  end

  it "can add a new micropost" do
    @user = FactoryGirl.create(:user)
    visit "/users/#{@user.id}/microposts"
    page.should have_selector("body h1", :content => "Listing microposts")
    click_link "New Micropost"
    within "form" do
      fill_in "Content", :with => "awesome stuff"
      fill_in "User", :with => "#{@user.id}"
      click_button "Create Micropost"
    end
    page.should have_selector("p#notice", :content => "Micropost was successfully created.")
    @micropost.user.id.should_not == @user.id
    page.should have_selector("body table tr td", :content => "awesome stuff")
  end

  it "shows the micropost" do
    visit "/users/#{@micropost.user.id}/microposts"
    find(:xpath, "//a[@href='/users/#{@micropost.user.id}/microposts/#{@micropost.id}']").click
    page.should have_selector("body p b", :content => "hello")
    page.should have_selector("body p b", :content => "#{@micropost.user.name}")
  end

  it "updates a micropost" do
    visit "/users/#{@micropost.user.id}/microposts"
    find(:xpath, "//a[@href='/users/#{@micropost.user.id}/microposts/#{@micropost.id}/edit']").click
    page.should have_selector("form", :content => "hello")
    within "form" do
      fill_in "Content", :with => "new shizzle"
      click_button "Update Micropost"
    end
    page.body.should have_selector("p#notice", :content => "Micropost was successfully updated.")
    page.should have_selector("b", :text => "Content:", :content => "new shizzle")
  end

  it "removes micropost for a given user" do
    @micropost2 = FactoryGirl.create(:micropost)
    visit "/users/#{@micropost.user.id}/microposts"
    find(:xpath, "//a[@href='/users/#{@micropost.user.id}/microposts/#{@micropost.id}'][@data-method='delete'][@rel='nofollow']").click
    @micropost.id.should == nil
    @micropost2.id.should_not == nil
  end
end
