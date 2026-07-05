require "test_helper"

class PainelControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get painel_index_url
    assert_response :success
  end
end
