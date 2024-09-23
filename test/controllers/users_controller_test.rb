require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    @team = teams(:yellow)
  end

  test "should get index" do
    get users_url, headers: { Authorization: "Plain system" }, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url,
        params: { user: { name: "Bob", email: "bob@example.com", team_id: @team.id } },
        headers: { Authorization: "Plain system" },
        as: :json
    end

    assert_response :created, response.body

    new_user = User.find(response.parsed_body["id"])
    assert new_user.wallet != nil
  end

  test "should show user" do
    get user_url(@user), headers: { Authorization: "Plain system" }, as: :json
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user),
      params: { user: { name: "Rudy", email: "rudy@example.com", team_id: nil } },
      headers: { Authorization: "Plain system" },
      as: :json
    assert_response :success
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user), headers: { Authorization: "Plain system" }, as: :json
    end

    assert_response :no_content
  end
end
