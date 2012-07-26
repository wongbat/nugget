require 'test/test_helper'

class MicropostTest < ActiveSupport::TestCase
  test "cannot save a content of > 140 chars" do
    content = "0" * 141
    mp = Micropost.new(:content => content)
    assert !mp.save
  end

  test "can save a content of < 140 chars" do
    content = "0" * 139
    mp = Micropost.new(:content => content)
    assert mp.save
  end

  test "can save a blank content" do
    mp = Micropost.new()
    assert mp.save    
  end
end
