require 'test_helper'

class PhonebooksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
