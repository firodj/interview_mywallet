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
end
