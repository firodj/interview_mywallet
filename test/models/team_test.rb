require "test_helper"

class TeamTest < ActiveSupport::TestCase
  test "save team without name will failed" do
    team = Team.new
    assert_not team.save
  end

  test "save team with name will success" do
    team = Team.new
    team.name = "Green Light"
    assert team.save
  end

  test "remove team which has some users will failed" do
    team = teams(:yellow)
    assert team.users.length > 0
    assert_raises(ActiveRecord::InvalidForeignKey) { team.delete }
  end

  test "remove team which doesnot have users will success" do
    team = Team.new
    team.name = "Red Light"
    team.save
    assert team.users.length == 0
    assert team.delete
  end

end
