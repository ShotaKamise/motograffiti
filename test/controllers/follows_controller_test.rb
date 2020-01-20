require 'test_helper'

class FollowsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get follows_new_url
    assert_response :success
  end

end
