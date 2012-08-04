require 'spec_helper'

describe "Users" do
  it "can add new user" do
    visit '/users'
    page.should have_css('h1', :text => 'Listing users')
    page.should have_css("table", :text => "Name", :text => "Email")
    click_link "New User"
    fill_in "Name", :with => "Nat"
    fill_in "Email", :with => "Foo"
    click_button "Create User"
    page.should have_content("User was successfully created.")
    page.should have_content("Nat")
    page.should have_content("Foo")
  end

  it "allows users to change their details" do
    FactoryGirl.create(:user)
    visit '/users'
    click_link "Edit"
    fill_in "Name", :with => "new name"
    fill_in "Email", :with => "new@email.com"
    click_button "Update User"
    page.body.should include("User was successfully updated.")
  end

  it "displays user's details on it's own" do
    FactoryGirl.create(:user)
    visit '/users'
    click_link "Show"
    page.should have_content("Name: Mog")
    page.should have_content("Email: mog@hotmail.com")
  end

  it "deletes the user" do
    FactoryGirl.create(:user)
    visit '/users'
    click_link "Destroy"
    page.body.should_not have_content("Mog")
    page.body.should_not have_content("mog@hotmail.com")
  end
end
