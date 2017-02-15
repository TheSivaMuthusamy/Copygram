require "test_helper"

class FollowFlowsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:Test1)
    @other = users(:Test2)
  end


end
