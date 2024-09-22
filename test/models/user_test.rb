require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "save user without name will failed" do
    user = User.new
    assert_not user.save
  end

  test "save user with name and email and no team will success" do
    user = User.new
    user.name = "Bob"
    user.email = "bob@example.com"
    assert user.save
  end

  test "save user with malform email will failed" do
    user = User.new
    user.name = "Bob"
    user.email = "example.com"
    assert_not user.save
  end

  test "update user with already others email will failed" do
    user = users(:alice)
    user.email = "john@example.com"
    assert_not user.save
  end

  test "update user with malformed email will failed" do
    user = users(:alice)
    user.email = "example.com"
    assert_not user.save
  end

end