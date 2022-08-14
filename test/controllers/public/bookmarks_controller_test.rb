require "test_helper"

class Public::BookmarksControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_bookmarks_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_bookmarks_destroy_url
    assert_response :success
  end
end
