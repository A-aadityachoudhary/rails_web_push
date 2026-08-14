require "test_helper"

class PageVisitsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get page_visits_create_url
    assert_response :success
  end
end
