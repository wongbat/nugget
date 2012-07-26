require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "name cannot be blank" do
    assert true
  end

  test "should not save blank name" do
    user = User.new
    assert !user.save, "saved while name field was blank"
  end

  test "should report error" do
    undefined_variable
    assert true
  end
  # test "the truth" do
  #   assert true
  # end
end
