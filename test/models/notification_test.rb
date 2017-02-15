require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def setup
    @user=users(:Test1)
    @other=users(:Test2)
    @post=posts(:Post1)
    @notification = @user.notifications.create(subscribed_user_id: @other.id,
                                              post_id: @post.id,
                                              identifier: @post.id,
                                              notice_type: "liked")
  end

  test "should be valid" do
    assert @notification.valid?
  end

  test "user_id should be present" do
    @notification.user_id = " "
    assert_not @notification.valid?
  end

  test "subscribed_user_id should be present" do
    @notification.subscribed_user_id = " "
    assert_not @notification.valid?
  end

  test "post_id should be present" do
    @notification.post_id = " "
    assert_not @notification.valid?
  end

  test "identifier should be present" do
    @notification.identifier = " "
    assert_not @notification.valid?
  end

  test "notice_type should be present" do
    @notification.notice_type = " "
    assert_not @notification.valid?
  end

end
