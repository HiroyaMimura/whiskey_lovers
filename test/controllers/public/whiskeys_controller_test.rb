require "test_helper"

class Public::WhiskeysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_whiskeys_index_url
    assert_response :success
  end

  test "should get show" do
    get public_whiskeys_show_url
    assert_response :success
  end

  test "should get new" do
    get public_whiskeys_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_whiskeys_edit_url
    assert_response :success
  end
end
