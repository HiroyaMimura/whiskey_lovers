require "test_helper"

class Admin::WhiskeysControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_whiskeys_show_url
    assert_response :success
  end
end
