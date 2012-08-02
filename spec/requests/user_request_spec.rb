require 'spec_helper'

describe "Users" do
  it "can add new user" do
    visit '/users'
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
    debugger
    click_link "Edit"
    fill_in "Name", :with => "new name"
    fill_in "Email", :with => "new@email.com"
    click_button "Update User"
    page.body.should include("User was successfully updated.")
  end
end

