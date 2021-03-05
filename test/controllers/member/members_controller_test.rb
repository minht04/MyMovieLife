require 'test_helper'

class Member::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get member_members_show_url
    assert_response :success
  end

end
