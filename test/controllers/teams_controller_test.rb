require "test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team = teams(:yellow)
    @team_nousers = teams(:blue)
  end

  test "should get index" do
    get teams_url,
      headers: { Authorization: "Plain system" },
      as: :json
    assert_response :success
  end

  test "should create team" do
    assert_difference("Team.count") do
      post teams_url,
        params: { team: { name: "Red Light" } },
        headers: { Authorization: "Plain system" },
        as: :json
    end

    assert_response :created

    new_team = Team.find(response.parsed_body["id"])
    assert new_team.wallet != nil
  end

  test "should show team" do
    get team_url(@team),
      headers: { Authorization: "Plain system" },
      as: :json
    assert_response :success
  end

  test "should update team" do
    patch team_url(@team),
      params: { team: { name: "Red Light" } },
      headers: { Authorization: "Plain system" },
      as: :json
    assert_response :success
  end

  test "should destroy team" do
    assert_difference("Team.count", -1) do
      delete team_url(@team_nousers),
        headers: { Authorization: "Plain system" },
        as: :json
    end

    assert_response :no_content
  end
end
