require "test_helper"

class Admin::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_comments_destroy_url
    assert_response :success
  end
end
