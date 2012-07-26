require 'spec/spec_helper'

describe User do
  describe "name" do
    it "should not save with a blank name" do
      user = User.new
      user.save.should == false
    end

    it "should save with a name" do
      user = User.new(:name => "test")
      user.save.should == true
    end
  end
end
