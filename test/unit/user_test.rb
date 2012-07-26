require 'test/test_helper'

class UserTest < ActiveSupport::TestCase

  test "should not save blank name" do
    user = User.new
    assert !user.save
  end

  test "can save if name present" do
    user = User.new(:name => "test")
    assert user.save
  end
end
