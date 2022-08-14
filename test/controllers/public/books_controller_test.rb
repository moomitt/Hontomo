require "test_helper"

class Public::BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_books_index_url
    assert_response :success
  end

  test "should get new" do
    get public_books_new_url
    assert_response :success
  end

  test "should get create" do
    get public_books_create_url
    assert_response :success
  end

  test "should get show" do
    get public_books_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_books_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_books_update_url
    assert_response :success
  end

  test "should get search" do
    get public_books_search_url
    assert_response :success
  end
end
