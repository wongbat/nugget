require 'spec/spec_helper'

describe Micropost do
  describe "content" do
    it "should not save where content > 140 characters" do
      content = "z"*141
      micropost = Micropost.new(:content => content)
      micropost.save.should == false
    end
    
    it "should save where content < 140 characters" do
      content = "ABC"
      micropost = Micropost.new(:content => content)
      assert micropost.save
    end
  end
end
