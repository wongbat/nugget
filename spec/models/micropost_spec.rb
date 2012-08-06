require 'spec_helper'

describe Micropost do

  describe "has a valid user" do
    FactoryGirl.create(:micropost)
    it { should validate_presence_of(:user) }
    it { should belong_to(:user) }
  end
  
  describe "it does not have a valid user" do
    FactoryGirl.create(:invalid_micropost)
    it {should_not be_valid}
  end

  describe "content" do
    it "should not save where content > 140 characters" do
      content = "z"*141
      micropost = Micropost.new(:content => content)
      micropost.save.should == false
    end

    it "should save where content < 140 characters" do
      micropost = FactoryGirl.build(:micropost)
      micropost.save.should == true
    end
  end
end
