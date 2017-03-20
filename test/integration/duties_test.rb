require 'test_helper'

class DutiesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get duties index" do
    get duties_url
    assert_response :success 
  end
  
end
