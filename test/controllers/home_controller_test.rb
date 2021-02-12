require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get home_path
    assert_response :success
  end

  test "should get about" do
    get about_path
    assert_response :success
  end

  test "should get contact" do
    get contact_path
    assert_response :success
  end

  test "should get privacy" do
    get privacy_path
    assert_response :success
  end

end
