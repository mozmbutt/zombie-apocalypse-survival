require "test_helper"

class Users::SurvivorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_survivor_index_url
    assert_response :success
  end
end
