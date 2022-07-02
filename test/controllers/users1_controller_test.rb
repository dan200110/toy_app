require "test_helper"

class Users1ControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get users1_new_url
    assert_response :success
  end
end
